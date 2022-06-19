#!/bin/sh

CURRENT_SPACE_TYPE=$(yabai -m query --spaces --window | jq -re '.[] | .type')
CURRENT_SPACE_INDEX=$(yabai -m query --spaces --window | jq -re '.[] | .index')

if [ "$CURRENT_SPACE_TYPE" = "stack" ]
then
  yabai -m config --space $CURRENT_SPACE_INDEX layout bsp
else
  yabai -m config --space $CURRENT_SPACE_INDEX layout stack
fi
