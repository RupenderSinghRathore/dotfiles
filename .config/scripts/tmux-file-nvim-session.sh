#!/bin/zsh

search_dirs=(~/dotfiles)

file=$(
    command fd '' "${search_dirs[@]}" \
        --type f \
        --hidden \
        --no-ignore \
        --exclude .git \
        --exclude .repos \
        --exclude '*.png' \
        --exclude '*.pdf' \
        --exclude '*.epub' \
        --exclude '*.zip' \
        --exclude '*.svg' \
        --absolute-path 2>/dev/null |
        sed "s|^$HOME/||" |
        fzf --prompt="Select file: "
)

if [ -n "$file" ]; then
    tmux rename-window nvim
    nvim "$HOME/$file"
fi
