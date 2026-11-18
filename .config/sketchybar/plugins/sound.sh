#!/usr/bin/env bash
# Sound popup: click the speaker in the bar to list every output and input
# device; click a device to make it the default (the popup stays open). Uses SwitchAudioSource
# (brew install switchaudio-osx).
#
#   sound.sh            (as the item's script)  refresh on click / device change
#   sound.sh select TYPE NAME                    switch TYPE (output|input) to NAME
#   sound.sh slider TYPE                         (slider script) set TYPE volume to $PERCENTAGE

PATH="/opt/homebrew/bin:$PATH"
SAS=SwitchAudioSource
ITEM=sound
PLUGIN="$HOME/.config/sketchybar/plugins/sound.sh"

if [ "$1" = "slider" ]; then
  # SketchyBar passes the clicked/dragged position as $PERCENTAGE.
  if [ "$SENDER" = mouse.clicked ] && [ -n "$PERCENTAGE" ]; then
    osascript -e "set volume $2 volume $PERCENTAGE" >/dev/null 2>&1
    sketchybar --set "$NAME" slider.percentage="$PERCENTAGE"
  fi
  exit 0
fi

# Current volume (0-100) for output|input, or empty if the device has no
# software volume (e.g. a monitor over DisplayPort).
volume_of() {
  local v
  v=$(osascript -e "$1 volume of (get volume settings)" 2>/dev/null)
  case "$v" in ''|*[!0-9]*) echo "" ;; *) echo "$v" ;; esac
}

add_slider() { # add_slider ROW TYPE
  local row=$1 type=$2 vol
  vol=$(volume_of "$type")
  if [ -z "$vol" ]; then
    sketchybar --add item "$row" popup."$ITEM" \
               --set "$row" icon.drawing=off \
                            label="fixed volume" \
                            label.color=0xff666666 \
                            label.padding_left=34 \
                            label.font="Hack Nerd Font:Italic:12.0"
    return
  fi
  if [ "$type" = output ]; then icon="󰕾"; else icon="󰍬"; fi
  sketchybar --add slider "$row" popup."$ITEM" 200 \
             --set "$row" slider.percentage="$vol" \
                          slider.highlight_color=0xff00eeff \
                          slider.background.height=6 \
                          slider.background.corner_radius=3 \
                          slider.background.color=0xff444444 \
                          slider.knob="" \
                          slider.knob.drawing=on \
                          icon="$icon" \
                          icon.padding_left=10 \
                          icon.width=24 \
                          label.drawing=off \
                          padding_right=14 \
                          script="$PLUGIN slider $type" \
             --subscribe "$row" mouse.clicked
}

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
    i=$((i + 1))
    add_slider "sound.row.$i" "$type"
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

# Switch device and redraw in place, so the popup stays open: the check mark
# moves and the slider shows the new device's volume.
if [ "$1" = "select" ]; then
  $SAS -t "$2" -s "$3" >/dev/null
  build_popup
  exit 0
fi

case "$SENDER" in
  mouse.clicked)
    build_popup
    sketchybar --set "$ITEM" popup.drawing=toggle
    ;;
  mouse.exited.global)
    sketchybar --set "$ITEM" popup.drawing=off
    ;;
esac
