#!/bin/bash
##!/bin/zsh

# Define the directories you want to search
search_dirs=(~/dotfiles ~/lunaar ~/Documents ~/Downloads)

# Search for files in the specified directories, optionally excluding certain subdirectories (e.g., .git)
file=$(find "${search_dirs[@]}" \
    -type d \( -name '.git' -o -name 'themes' -o -name '.venv' -o -name 'node_modules' \) -prune \
    -o \
    -type f \( ! -name '*.png' ! -name '*.pdf' ! -name '*.epub' ! -name '*.zip' \) -print |
    fzf --prompt="Select file: ")
# Open the selected file in Neovim if a file is selected
[ -n "$file" ] && nvim "$file"
