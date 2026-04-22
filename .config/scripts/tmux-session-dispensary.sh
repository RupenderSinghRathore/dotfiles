#!/bin/bash

DIRS=(
    "$HOME/lunaar"
    "$HOME/dotfiles"
)

# if [[ $# -eq 1 ]]; then
#     selected="$1"
# else
selected=$(
    fd . "${DIRS[@]}" \
        --max-depth 2 \
        --type d \
        --no-ignore \
        --hidden \
        --exclude .git \
        --exclude themes \
        --exclude .venv \
        --exclude node_modules \
        --exclude env \
        --exclude venv \
        --exclude .gradle \
        --exclude META-INF \
        --exclude target \
        --exclude .cache \
        --exclude utils |
        sed "s|^$HOME/||" |
        fzf --prompt="New Tmux Session: "
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
