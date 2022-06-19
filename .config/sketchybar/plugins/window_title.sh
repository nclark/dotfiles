#!/bin/bash

WINDOW_TITLE_LENGTH=40
WINDOW_TITLE=$(yabai -m query --windows --window | jq -r '.app')

if [[ ${#WINDOW_TITLE} -gt ${WINDOW_TITLE_LENGTH} ]]; then
  WINDOW_TITLE=$(echo "$WINDOW_TITLE" | cut -c 1-${WINDOW_TITLE_LENGTH})
fi

sketchybar -m --set title \
                    label="${WINDOW_TITLE}" \
                    label.padding_left=-10    \
                    label.padding_right=0
