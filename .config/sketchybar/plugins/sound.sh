#!/usr/bin/env bash
# Sound popup: click the speaker in the bar to list every output and input
# device; click a device to make it the default. Uses SwitchAudioSource
# (brew install switchaudio-osx).
#
#   sound.sh            (as the item's script)  refresh on click / device change
#   sound.sh select TYPE NAME                    switch TYPE (output|input) to NAME

PATH="/opt/homebrew/bin:$PATH"
SAS=SwitchAudioSource
ITEM=sound
PLUGIN="$HOME/.config/sketchybar/plugins/sound.sh"

if [ "$1" = "select" ]; then
  $SAS -t "$2" -s "$3" >/dev/null
  sketchybar --set "$ITEM" popup.drawing=off
  exit 0
fi

build_popup() {
  sketchybar --remove '/sound\.row\..*/' >/dev/null 2>&1

  local i=0 type current name mark
  for type in output input; do
    current=$($SAS -c -t "$type")
    i=$((i + 1))
    if [ "$type" = output ]; then header="Output"; else header="Input"; fi
    sketchybar --add item "sound.row.$i" popup."$ITEM" \
               --set "sound.row.$i" icon.drawing=off \
                                    label="$header" \
                                    label.color=0xff888888 \
                                    label.font="Hack Nerd Font:Bold:12.0" \
                                    background.drawing=off
    while IFS= read -r name; do
      [ -z "$name" ] && continue
      i=$((i + 1))
      if [ "$name" = "$current" ]; then mark="󰄬"; else mark=" "; fi
      sketchybar --add item "sound.row.$i" popup."$ITEM" \
                 --set "sound.row.$i" icon="$mark" \
                                      icon.color=0xff00eeff \
                                      icon.padding_left=10 \
                                      icon.width=24 \
                                      label="$name" \
                                      label.padding_right=14 \
                                      click_script="$PLUGIN select $type $(printf '%q' "$name")"
    done < <($SAS -a -t "$type")
  done
}

case "$SENDER" in
  mouse.clicked)
    build_popup
    sketchybar --set "$ITEM" popup.drawing=toggle
    ;;
  mouse.exited.global)
    sketchybar --set "$ITEM" popup.drawing=off
    ;;
esac
