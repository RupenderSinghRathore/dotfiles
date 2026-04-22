#!/bin/zsh

file=$(fd --max-depth 3 \
    --no-ignore \
    --hidden \
    --exclude .git \
    --exclude node_modules \
    --exclude .venv \
    --exclude target \
    --type f |
    fzf --height 40% --reverse --prompt="Select file: " --print-query | tail -1)

# Open the selected file in Neovim if a file is selected
tmux rename-window nvim
[ -n "$file" ] && nvim "$file"
# [ -n "$file" ]
# nvim "$file"
