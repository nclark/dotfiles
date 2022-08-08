#!/bin/sh

HEIGHT=$(yabai -m query --displays | jq '.[].frame.h')

# note - can I get rid of this ?
if [ $HEIGHT -lt 1080 ]; then
  yabai -m config external_bar all:38:0
else
  yabai -m config external_bar all:38:0
fi

