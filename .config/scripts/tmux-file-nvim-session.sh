#!/bin/bash
##!/bin/zsh

# Define the directories you want to search
search_dirs=(Documents Downloads dotfiles lunaar)

# Search for files in the specified directories, optionally excluding certain subdirectories (e.g., .git)
file=$(find "${search_dirs[@]}" -type d -name '.git' -prune -o -type f -print | fzf --prompt="Select file: ")

# Open the selected file in Neovim if a file is selected
[ -n "$file" ] && nvim "$file"

