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
        yabai -m window --grid 10:10:2:2:6:6
        ;;
    *)
        exit
        ;;
esac
