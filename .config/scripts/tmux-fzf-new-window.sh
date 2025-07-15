#!/bin/zsh

search_dirs=(Documents Downloads Projects lunaar dotfiles Games)
dir=$(find "${search_dirs[@]}" -type d -name '.git' -prune -o -type d -print 2>/dev/null | fzf --prompt="Select directory: ")

if [ -n "$dir" ]; then
    tmux new-window -c "$dir"
fi

