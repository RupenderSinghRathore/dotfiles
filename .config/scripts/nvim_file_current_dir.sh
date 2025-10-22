#!/bin/zsh

file=$(find -type d \( -name '.git' -o -name 'themes' -o -name '.venv' -o -name 'node_modules' -o -name '.gradle' -o -name 'META-INF' -o -name '.cache' -o -name 'env' \) -prune \
    -o \
    -type f \( ! -name '*.png' ! -name '*.pdf' ! -name '*.epub' ! -name '*.zip' ! -name '*.db' ! -name '*.class' \) -print |
    sed "s|^\./||" |
    fzf --prompt="Select file: ")

# Open the selected file in Neovim if a file is selected
tmux rename-window nvim
[ -n "$file" ] && nvim "$file"
