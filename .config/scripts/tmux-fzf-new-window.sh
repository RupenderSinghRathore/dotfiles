#!/bin/bash

search_dirs=(~/dotfiles ~/lunaar ~/Documents ~/Downloads)
    dir=$(
        find "${search_dirs[@]}" -type d \
            \( -name '.git' -o -name 'themes' -o -name '.venv' -o -name 'node_modules' -o -name '.gradle' -o -name 'META-INF' \) -prune \
            -o -type d -print 2>/dev/null \
        | sed "s|^$HOME/||" \
        | fzf --prompt="Select directory: "
    )

if [ -n "$dir" ]; then
    tmux new-window -c "$HOME/$dir"
fi
