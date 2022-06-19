#!/bin/sh

HEIGHT=$(yabai -m query --displays | jq '.[].frame.h')

if [ $HEIGHT -lt 1080 ]; then
  yabai -m config top_padding 5
else
  yabai -m config top_padding 38
fi

