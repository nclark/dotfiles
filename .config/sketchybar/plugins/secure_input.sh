#!/usr/bin/env bash

# Shows a lock and the app name while some app holds macOS Secure Event Input.
# While it is on, macOS hides keystrokes from skhd, so hotkeys stop working.
# Clicking the item brings that app to the front so you can leave the
# password field (or quit the app) and release the lock.
#
# Reads only the IORegistry root entry (~10 ms); a full `ioreg -l` takes ~1 s.

# Parsed with a bash regex so the script has no PATH needs beyond /usr/sbin.
PID=""
if [[ "$(/usr/sbin/ioreg -n Root -d1 -w 0)" =~ kCGSSessionSecureInputPID\"=([0-9]+) ]]; then
  PID="${BASH_REMATCH[1]}"
fi

if [ -z "$PID" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

COMM=$(ps -o comm= -p "$PID")
if [[ "$COMM" == *.app/* ]]; then
  APP=$(basename "${COMM%%.app/*}")
else
  APP=$(basename "$COMM")
fi

sketchybar --set "$NAME" drawing=on \
                         label="${APP:-pid $PID}" \
                         click_script="osascript -e 'tell application \"System Events\" to set frontmost of (first process whose unix id is $PID) to true'"
