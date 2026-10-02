#!/bin/sh
# Move (break) the focused pane into its own new tab, asking for a tab name first.
# Run from a herdr popup keybinding. Herdr sets HERDR_ACTIVE_PANE_ID to the tiled
# pane under the popup. Leave the name blank to use herdr's default tab name.
# Press Ctrl+C to cancel.
set -eu

herdr="${HERDR_BIN_PATH:-herdr}"
pane="${HERDR_ACTIVE_PANE_ID:?no active pane}"

printf 'New tab name (blank = default, Ctrl+C = cancel): '
IFS= read -r name || exit 0

if [ -n "$name" ]; then
  "$herdr" pane move "$pane" --new-tab --label "$name" --focus >/dev/null
else
  "$herdr" pane move "$pane" --new-tab --focus >/dev/null
fi
