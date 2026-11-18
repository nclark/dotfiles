#!/usr/bin/env bash

source "$HOME/.zsh/private" 2>/dev/null

exec /Users/nclark/.local/share/mise/shims/ruby "$(dirname "$0")/next_event.rb"
