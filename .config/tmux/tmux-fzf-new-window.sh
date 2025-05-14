#!/bin/bash

# dir=$(find . -type d | fzf-tmux -p 80%,50%) || exit 0
# [ -n "$dir" ] && tmux new-window -c "$dir"
#
#!/usr/bin/env bash

# Use fzf to select a directory
dir=$(find ~ -type d 2>/dev/null | fzf --prompt="Select directory: ")

# If a directory was selected, open a new tmux window there
if [ -n "$dir" ]; then
    tmux new-window -c "$dir"
fi
