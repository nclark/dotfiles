#!/usr/bin/env bash

STATE_FILE="$HOME/.cache/sketchybar/next_event_url"

if [ -s "$STATE_FILE" ]; then
  open "$(cat "$STATE_FILE")"
fi
