#!/usr/bin/env bash
# Take over the bar while an skhd chord mode is on (leader: cmd - ;,
# window: cmd - y). Triggered by ~/bin/skhd-leader:
#   sketchybar --trigger skhd_mode MODE=leader|window|default
#
# In a mode, every other item is hidden, the bar fades to the mode's color
# with a glowing border, and the centered `skhd_mode` item lists the keys,
# read from skhdrc so new ones show up: the mode's `#@ MODE  KEY  TEXT`
# lines if it has any, otherwise each bind's trailing comment. On exit, the
# items that were showing come back.
PATH="/opt/homebrew/bin:$PATH"
SKHDRC="$HOME/.config/skhd/skhdrc"

BAR_COLOR=0xB3333333        # keep in sync with `--bar color` in sketchybarrc
HIDDEN="$HOME/.cache/sketchybar/skhd_mode.hidden"   # items we hid, to restore
WANT="$HOME/.cache/sketchybar/skhd_mode.want"       # latest mode (bin/skhd-leader)
LOCK="$HOME/.cache/sketchybar/skhd_mode.lock"
mkdir -p "${HIDDEN%/*}"

# One run at a time. Entering is slow (it asks each item whether it's
# showing), so a quick "cmd - ; then s" fires the exit while the entry is
# still hiding items; two overlapping runs left the bar half hidden with
# nothing recorded to restore. Each run waits for the lock, then acts on the
# latest mode from $WANT rather than the event that started it. A lock older
# than 10 s is stale (a run that died) and gets cleared.
for _ in $(seq 1 200); do
  mkdir "$LOCK" 2>/dev/null && break
  age=$(( $(date +%s) - $(stat -f %m "$LOCK" 2>/dev/null || date +%s) ))
  [ "$age" -gt 10 ] && rmdir "$LOCK" 2>/dev/null
  sleep 0.05
done
trap 'rmdir "$LOCK" 2>/dev/null' EXIT
if [ "$SENDER" = skhd_mode ]; then
  [ -s "$WANT" ] && MODE=$(/bin/cat "$WANT")
else
  MODE=default   # SketchyBar startup or reload: always the normal bar
  echo default > "$WANT"
fi

case "$MODE" in
  leader) GLOW_BAR=0xE64a2a10 GLOW=0xfffaa968 ICON="󱓞" ;;   # amber: apps
  window) GLOW_BAR=0xE60f2a4a GLOW=0xff6cb6ff ICON="" ;;   # blue: windows
esac

if [ "$MODE" = default ] || [ -z "$GLOW" ]; then
  args=()
  if [ -f "$HIDDEN" ]; then
    while IFS= read -r item; do args+=(--set "$item" drawing=on); done < "$HIDDEN"
    rm -f "$HIDDEN"
  fi
  sketchybar --set "$NAME" drawing=off "${args[@]}" \
             --animate tanh 12 \
             --bar color=$BAR_COLOR border_color=0xff000000 border_width=0
  exit 0
fi

if rg -q "^#@ $MODE " "$SKHDRC"; then
  hints=$(rg "^#@ $MODE +(.+?)  +(.+)$" -or '$1  $2' "$SKHDRC")
else
  hints=$(rg "^$MODE < ([^:]+?) *:.*# *([^(/]+?) *(\(|/|\$).*" -or '$1  $2' "$SKHDRC" | rg -v '^escape')
fi
hints=$(printf '%s\n' "$hints" | sed -E 's/^shift - /⇧/' | awk '{printf "%s%s", (NR > 1 ? "     " : ""), $0}')

# Hide everything that's showing now, and remember it (once per mode entry).
args=()
if [ ! -s "$HIDDEN" ]; then
  while IFS= read -r item; do
    [ "$item" = "$NAME" ] && continue
    [ "$(sketchybar --query "$item" | jq -r '.geometry.drawing')" = on ] || continue
    printf '%s\n' "$item" >> "$HIDDEN"
    args+=(--set "$item" drawing=off)
  done < <(sketchybar --query bar | jq -r '.items[]')
fi

sketchybar "${args[@]}" \
           --animate tanh 8 \
           --bar color=$GLOW_BAR border_color=$GLOW border_width=2 \
           --set "$NAME" drawing=on icon="$ICON" icon.color=$GLOW label="$hints"
