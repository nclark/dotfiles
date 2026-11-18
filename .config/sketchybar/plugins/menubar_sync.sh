#!/usr/bin/env bash
# Mirror the real (hidden) macOS menu bar on the right side of SketchyBar, so
# each icon sits exactly under the real one when the menu bar slides down.
#
# Walks the real menu bar right to left from Battery to Amphetamine and, for
# each slot, adds:
#   - an alias, if it's an icon we show (SHOW_APPS, or a named system item)
#   - the `sound` popup item, if it's the PLACEHOLDER app's slot
#   - an empty gap of the same width, for anything else
# so a new or unexpected icon can't knock the row out of line.
#
# SketchyBar names third-party icons "Control Center,Item-0(N)", where N is the
# slot's position counting right to left (src/alias.c). menubar-map
# (~/.local/bin, source in ../helpers) rebuilds that numbering and asks each
# app through Accessibility where its icon is.
#
# Runs from the hidden `menubar_sync` item: every 60 s, on wake, and on the
# custom `menubar_changed` event (yabai fires it on app launch/terminate).
# Needs Accessibility + Screen Recording for sketchybar itself.

PATH="/opt/homebrew/bin:$HOME/.local/bin:$PATH"
STATE="$HOME/.cache/sketchybar/menubar_sync.state"
mkdir -p "${STATE%/*}"

PLACEHOLDER="WireGuard"                       # real slot that sits under `sound`
SHOW_APPS=("WeatherMenu" "CleanShot X" "FluidVoice" "Amphetamine")
SHOW_SYSTEM="Battery|Bluetooth|com.apple.menuextra.TimeMachine"  # Control Center names
START_NAME="Battery"                          # rightmost slot of the row
END_ALIAS_PREFIX="Control Center,Amphetamine" # leftmost slot of the row

# Build the helper on a fresh machine (it isn't tracked as a binary).
if ! command -v menubar-map >/dev/null 2>&1; then
  mkdir -p "$HOME/.local/bin"
  swiftc -O -o "$HOME/.local/bin/menubar-map" \
    "$HOME/.config/sketchybar/helpers/menubar-map.swift" >/dev/null 2>&1 || exit 0
fi

apps=$(menubar-map "$PLACEHOLDER" "${SHOW_APPS[@]}" 2>/dev/null) || exit 0
slots=$(menubar-map --list 2>/dev/null) || exit 0
[ -z "$apps" ] || [ -z "$slots" ] && exit 0

# Fast path: nothing moved.
signature="$apps"$'\n--\n'"$slots"
if [ -f "$STATE" ] && [ "$signature" = "$(cat "$STATE")" ]; then
  exit 0
fi

placeholder_alias=$(printf '%s\n' "$apps" | head -1 | cut -f2)
show_aliases=$(printf '%s\n' "$apps" | tail -n +2 | cut -f2)

# Remove everything we mirrored last time.
sketchybar --query bar | jq -r '.items[]' | while IFS= read -r item; do
  case "$item" in
    "Control Center,"*|"WeatherMenu,"*|menubar_gap.*) sketchybar --remove "$item" >/dev/null 2>&1 ;;
  esac
done

# alias_item NAME CENTER_X: mirror NAME; clicking it presses the real icon
# at CENTER_X (menubar-map --press-at), so its menu opens without revealing
# the menu bar. The near-invisible background (alpha 1/255, full bar height)
# makes the whole slot clickable: macOS passes clicks on fully transparent
# pixels through, which made only the icon's drawn pixels respond and let
# stray clicks land on whatever was underneath.
alias_item() {
  sketchybar --add alias "$1" right            \
             --set "$1" padding_left=-1        \
                        click_script="$HOME/.local/bin/menubar-map --press-at $2" \
                        background.drawing=on  \
                        background.color=0x01000000 \
                        background.height=33   \
                        padding_right=-1       \
                        icon.padding_left=0    \
                        icon.padding_right=0   \
                        label.padding_left=0   \
                        label.padding_right=0
}

order=(clock amphetamine_sep)
started=0 gap=0 sound_done=0
while IFS=$'\t' read -r alias x w; do
  w=${w#w=}; x=${x#x=}
  [ "$started" = 0 ] && case "$alias" in "Control Center,$START_NAME("*) started=1 ;; *) continue ;; esac
  [ "${w:-0}" -le 0 ] || [ "$w" -ge 300 ] && continue   # invisible panels

  name=${alias#*,}; name=${name%(*}
  if [ "$alias" = "$placeholder_alias" ]; then
    sketchybar --set sound width="$w" icon.width="$w"
    order+=(sound); sound_done=1
  elif printf '%s\n' "$show_aliases" | grep -qxF "$alias" \
       || { [ "${alias%%,*}" = "Control Center" ] && [[ "$name" =~ ^($SHOW_SYSTEM)$ ]]; }; then
    alias_item "$alias" $((x + w / 2)); order+=("$alias")
  else
    gap=$((gap + 1))
    sketchybar --add item "menubar_gap.$gap" right \
               --set "menubar_gap.$gap" width="$w" icon.drawing=off label.drawing=off
    order+=("menubar_gap.$gap")
  fi

  case "$alias" in "$END_ALIAS_PREFIX"*) break ;; esac
done < <(printf '%s\n' "$slots")

# Placeholder app not running: keep the speaker, just at a normal width.
if [ "$sound_done" = 0 ]; then
  sketchybar --set sound width=32 icon.width=32
  order+=(sound)
fi
order+=(menubar_sync secure_input)

sketchybar --reorder "${order[@]}" >/dev/null 2>&1
printf '%s\n' "$signature" > "$STATE"
