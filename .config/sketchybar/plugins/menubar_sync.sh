#!/usr/bin/env bash
# Keep the mirrored menu bar icons pointing at the right real icons.
#
# SketchyBar names third-party menu bar icons "Control Center,Item-0(N)",
# where N is the icon's position counting right to left. N shifts whenever
# an app to the right quits, relaunches, or a temporary macOS icon appears.
# menubar-map (~/.local/bin, source in ../helpers) asks each app through the
# Accessibility API where its icon is and returns the current alias name.
# If the answer changed since last run, rebuild the mirrored aliases.
#
# Runs from the hidden `menubar_sync` item: every 60 s, on wake, and on the
# custom `menubar_changed` event (yabai fires it on app launch/terminate).
# Needs Accessibility + Screen Recording for sketchybar itself.

PATH="/opt/homebrew/bin:$HOME/.local/bin:$PATH"
STATE="$HOME/.cache/sketchybar/menubar_sync.state"
mkdir -p "${STATE%/*}"

# Slots, right to left, after Battery and Bluetooth (those have stable names).
# PLACEHOLDER app: its real icon only holds the space under the `sound` item.
PLACEHOLDER="WireGuard"
APPS=("WeatherMenu" "CleanShot X" "FluidVoice" "Amphetamine")

# Build the helper on a fresh machine (it isn't tracked as a binary).
if ! command -v menubar-map >/dev/null 2>&1; then
  mkdir -p "$HOME/.local/bin"
  swiftc -O -o "$HOME/.local/bin/menubar-map" \
    "$HOME/.config/sketchybar/helpers/menubar-map.swift" >/dev/null 2>&1 || exit 0
fi

map=$(menubar-map "$PLACEHOLDER" "${APPS[@]}" 2>/dev/null) || exit 0
[ -z "$map" ] && exit 0

# Fast path: nothing moved.
if [ -f "$STATE" ] && [ "$map" = "$(cat "$STATE")" ]; then
  exit 0
fi

alias_item() {
  sketchybar --add alias "$1" right            \
             --set "$1" padding_left=-1        \
                        padding_right=-1       \
                        icon.padding_left=0    \
                        icon.padding_right=0   \
                        label.padding_left=0   \
                        label.padding_right=0
}

# Drop the old mirrored aliases (everything we created last time).
if [ -f "$STATE" ]; then
  while IFS=$'\t' read -r _ name _; do
    [ "$name" != "-" ] && sketchybar --remove "$name" >/dev/null 2>&1
  done < <(tail -n +2 "$STATE")
fi

# Sound sits over the placeholder; match its width, or fall back if it's gone.
ph_width=$(printf '%s\n' "$map" | head -1 | cut -f3)
if [ "${ph_width:-0}" -gt 0 ]; then
  sketchybar --set sound width="$ph_width" icon.width="$ph_width"
else
  sketchybar --set sound width=32 icon.width=32
fi

order=(clock amphetamine_sep "Control Center,Battery" "Control Center,Bluetooth" sound)
while IFS=$'\t' read -r _ name _; do
  [ "$name" = "-" ] && continue     # app not running: its real slot is gone too
  alias_item "$name"
  order+=("$name")
done < <(printf '%s\n' "$map" | tail -n +2)
order+=(secure_input)

# Put the right side back in order (added items land at the far left).
sketchybar --reorder "${order[@]}" >/dev/null 2>&1

printf '%s\n' "$map" > "$STATE"
