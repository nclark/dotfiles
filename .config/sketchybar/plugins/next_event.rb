#!/Users/nclark/.local/share/mise/shims/ruby
# Polls $ENOVIS_ICS_URL directly and renders the current/next calendar event
# as sketchybar label text. No screen capture, no menu-bar aliasing -- those
# were tried first for Outlook/MeetingBar/BusyCal and all failed identically
# (sketchybar's alias feature can locate/size text-based status items but
# never renders their captured content). This sidesteps that entirely.

require 'icalendar/recurrence'
require 'open3'
require 'fileutils'
require 'time'

NAME = ENV['NAME'] || 'next_event'
ICS_URL = ENV['ENOVIS_ICS_URL']
STATE_FILE = File.expand_path('~/.cache/sketchybar/next_event_url')
CACHE_FILE = File.expand_path('~/.cache/sketchybar/next_event_ics_cache.ics')
EXCLUDE_FILE = File.join(__dir__, 'next_event_exclude.txt')
MAX_SUMMARY_LEN = 24
WHITE = '0xffffffff'
ORANGE = '0xffffa500'
# Orange from 5 minutes before an event starts until 1 minute after. sketchybar
# calls this script every 5s (update_freq=5) so this timing is accurate --
# the network fetch itself is throttled separately, below.
LEAD_SECONDS = 5 * 60
GRACE_SECONDS = 60
# Only actually hit the network this often; every other invocation (every 5s)
# reads the cached ICS body and just recomputes against the current time.
CACHE_TTL_SECONDS = 10 * 60

def set_label(text, color: WHITE)
  system('sketchybar', '--set', NAME, "label=#{text} ┊", "label.color=#{color}")
end

def cache_age
  File.exist?(CACHE_FILE) ? Time.now - File.mtime(CACHE_FILE) : Float::INFINITY
end

def write_cache(body)
  FileUtils.mkdir_p(File.dirname(CACHE_FILE))
  File.write(CACHE_FILE, body)
end

# The feed is ~1.7MB and the server can dribble it out for 20s+, so the
# render path must never wait on the network: sketchybar fires this script
# every 5s and skips an item whose script is still running -- a blocking
# fetch here once piled up and wedged the item entirely. Instead, always
# render from the cache and refresh it with a detached curl: at most one
# in flight (lock dir), at most one attempt per minute (marker file) so a
# throttled/erroring feed doesn't get hammered.
LOCK_DIR = "#{CACHE_FILE}.lock"
ATTEMPT_FILE = "#{CACHE_FILE}.last_attempt"

def refresh_cache_async
  return if File.exist?(ATTEMPT_FILE) && Time.now - File.mtime(ATTEMPT_FILE) < 60

  if File.directory?(LOCK_DIR)
    # A fetcher killed with SIGKILL leaves the lock behind; reap it once
    # it's older than any possible curl run.
    return if Time.now - File.mtime(LOCK_DIR) < 120

    FileUtils.rm_rf(LOCK_DIR)
  end

  FileUtils.mkdir_p(File.dirname(CACHE_FILE))
  begin
    Dir.mkdir(LOCK_DIR)
  rescue Errno::EEXIST
    return
  end
  FileUtils.touch(ATTEMPT_FILE)

  script = 'trap \'rmdir "$LOCK" 2>/dev/null\' EXIT; ' \
           'if curl -fsSL --max-time 45 -o "$TMP" "$URL"; ' \
           'then mv -f "$TMP" "$CACHE"; else rm -f "$TMP"; fi'
  pid = Process.spawn(
    { 'URL' => ICS_URL, 'TMP' => "#{CACHE_FILE}.tmp", 'CACHE' => CACHE_FILE, 'LOCK' => LOCK_DIR },
    'sh', '-c', script,
    %i[out err] => '/dev/null', pgroup: true
  )
  Process.detach(pid)
end

# Fresh cache -> use it as-is. Expired cache -> kick off a background
# refresh and render from the stale copy; slightly older event data is
# still correct for events we already know about. Only the very first run
# (no cache at all) fetches synchronously.
def fetch_ics
  if cache_age > CACHE_TTL_SECONDS
    if File.exist?(CACHE_FILE)
      refresh_cache_async
    else
      body, status = Open3.capture2('curl', '-fsSL', '--max-time', '45', ICS_URL)
      write_cache(body) if status.success? && !body.empty?
    end
  end

  return File.read(CACHE_FILE) if File.exist?(CACHE_FILE)

  nil
end

def load_exclude_patterns
  return [] unless File.exist?(EXCLUDE_FILE)

  File.readlines(EXCLUDE_FILE).filter_map do |line|
    line = line.strip
    next if line.empty? || line.start_with?('#')

    begin
      Regexp.new(line)
    rescue RegexpError
      nil
    end
  end
end

def write_join_url(url)
  FileUtils.mkdir_p(File.dirname(STATE_FILE))
  File.write(STATE_FILE, url.to_s)
end

def truncate(text, len)
  text.length > len ? "#{text[0, len - 1]}…" : text
end

def join_url_for(event)
  custom = event.custom_properties['x_microsoft_skypeteamsmeetingurl']&.first
  return custom if custom

  text = "#{event.description} #{event.location}"
  match = text.match(%r{https?://[^\s"<>]*(?:teams\.microsoft\.com|zoom\.us|meet\.google\.com)[^\s"<>]*})
  match && match[0]
end

if ICS_URL.to_s.empty?
  set_label('No ICS URL')
  write_join_url(nil)
  exit
end

raw = fetch_ics
if raw.nil?
  set_label('Cal error')
  write_join_url(nil)
  exit
end

begin
  calendars = Icalendar::Calendar.parse(raw)
rescue => e
  set_label('Cal parse error')
  write_join_url(nil)
  exit
end

now = Time.now
window_start = now - (60 * 60)
# Bounded to end of today (local) -- never show tomorrow's events.
window_end = Time.local(now.year, now.month, now.day, 23, 59, 59)

exclude_patterns = load_exclude_patterns

occurrences = []
Array(calendars).each do |cal|
  cal.events.each do |event|
    summary = event.summary.to_s
    next if exclude_patterns.any? { |re| re.match?(summary) }

    begin
      event.occurrences_between(window_start, window_end).each do |occ|
        occurrences << { event: event, start: occ.start_time, finish: occ.end_time }
      end
    rescue StandardError
      # Some events in real-world feeds have malformed recurrence data that
      # icalendar-recurrence can't expand -- skip just that event rather
      # than losing the whole feed.
      next
    end
  end
end

current = occurrences.select { |o| o[:start] <= now && now < o[:finish] }
                      .min_by { |o| o[:finish] }
upcoming = occurrences.select { |o| o[:start] > now }
                      .min_by { |o| o[:start] }

if current
  mins_left = ((current[:finish] - now) / 60).round
  summary = truncate(current[:event].summary.to_s, MAX_SUMMARY_LEN)
  color = (now - current[:start] < GRACE_SECONDS) ? ORANGE : WHITE
  set_label("#{summary} ⇠ #{mins_left}m", color: color)
  write_join_url(join_url_for(current[:event]))
elsif upcoming
  mins_until = ((upcoming[:start] - now) / 60).round
  summary = truncate(upcoming[:event].summary.to_s, MAX_SUMMARY_LEN)
  color = (upcoming[:start] - now <= LEAD_SECONDS) ? ORANGE : WHITE
  set_label("#{summary} ⇢ #{mins_until}m", color: color)
  write_join_url(join_url_for(upcoming[:event]))
else
  set_label('No meetings')
  write_join_url(nil)
end
