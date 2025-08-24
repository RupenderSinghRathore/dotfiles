#!/bin/bash

DIRS=(
    "$HOME/lunaar"
    "$HOME/dotfiles"
)

# if [[ $# -eq 1 ]]; then
#     selected="$1"
# else
    selected=$(
        find "${DIRS[@]}" -type d \
            \( -name '.git' -o -name 'themes' -o -name '.venv' -o -name 'node_modules' -o -name '.gradle' -o -name 'META-INF' \) -prune \
            -o -type d -print 2>/dev/null \
        | sed "s|^$HOME/||" \
        | fzf --prompt="New Tmux Session: "
    )
    [[ $selected ]] && selected="$HOME/$selected"
# fi

[[ ! $selected ]] && exit 0

selected_name=$(basename "$selected" | tr . _)
if ! tmux has-session -t "$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name:1"
fi

tmux switch-client -t "$selected_name"

