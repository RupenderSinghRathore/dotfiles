#!/bin/bash

search_dirs=(Documents Downloads Projects lunaar dotfiles Games)
dir=$(find "${search_dirs[@]}" -type d -name '.git' -o -name 'env' -o -name 'target' -prune -o -type d -print 2>/dev/null | fzf --prompt="Select directory: ")

if [ -n "$dir" ]; then
    session_name=$(basename "$dir")
    tmux new-session -d -s "$session_name" -c "$dir"
    tmux attach-session -t "$session_name"
    # kitty @ launch --type=tab tmux new-session -s "$session_name" -c "$dir"
fi

# This is pretty shit with a shit shortcut
# If this can be launched from the tmux's command mode maybe this might work
