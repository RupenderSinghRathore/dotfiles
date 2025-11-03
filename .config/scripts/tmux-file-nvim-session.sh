#!/bin/zsh

# Define the directories you want to search
search_dirs=(~/dotfiles ~/lunaar)

# Search for files in the specified directories, optionally excluding certain subdirectories (e.g., .git)
file=$(find "${search_dirs[@]}" -type d \
    \( -name '.git' -o -name 'themes' -o -name '.venv' -o -name 'node_modules' -o -name 'env' -o -name 'venv' -o -name '.gradle' -o -name 'META-INF' -o -name 'target' -o -name '.cache' -o -name 'utils' -o -name 'CTFd' -o -name 'javascript-exercises' -o -name 'css-exercises' \) -prune \
    -o \
    -type f \( ! -name '*.png' -a ! -name '*.pdf' -a ! -name '*.epub' -a ! -name '*.zip' \) -print |
    sed "s|^$HOME/||" |
    fzf --prompt="Select file: ")

if [ -n "$file" ]; then
    tmux rename-window nvim
    nvim "$HOME/$file"
fi
