#!/bin/bash

file=$(find -type d \( -name '.git' -o -name 'themes' -o -name '.venv' -o -name 'node_modules' -o -name '.gradle' -o -name 'META-INF' \) -prune \
    -o \
    -type f \( ! -name '*.png' ! -name '*.pdf' ! -name '*.epub' ! -name '*.zip' ! -name '*.db' ! -name '*.class' \) -print |
    fzf --prompt="Select file: ")

# Open the selected file in Neovim if a file is selected
[ -n "$file" ] && nvim "$file"
