#!/bin/bash

FLOATING=$(yabai -m query --windows --window | jq '.["is-floating"]')

if [ $FLOATING = "false" ]; then
    yabai -m window --toggle float
fi

case $1 in
    right)
        yabai -m window --grid 10:10:5:0:5:10
        ;;
    left)
        yabai -m window --grid 10:10:0:0:5:10
        ;;
    center)
        # Fixed size, centered on the window's display. Clamped so it
        # never exceeds the display (e.g. the laptop screen alone).
        W=1987
        H=1115
        read -r DX DY DW DH < <(yabai -m query --displays --window \
            | jq -r '.frame | "\(.x|floor) \(.y|floor) \(.w|floor) \(.h|floor)"')
        [ "$W" -gt "$DW" ] && W=$DW
        [ "$H" -gt "$DH" ] && H=$DH
        yabai -m window --resize abs:$W:$H
        yabai -m window --move abs:$((DX + (DW - W) / 2)):$((DY + (DH - H) / 2))
        ;;
    *)
        exit
        ;;
esac
