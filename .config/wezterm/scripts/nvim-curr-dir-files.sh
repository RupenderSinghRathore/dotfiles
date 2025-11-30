#!/bin/zsh

# 1. Your original find logic
file=$(find -type d \( -name '.git' -o -name 'themes' -o -name '.venv' -o -name 'node_modules' -o -name '.gradle' -o -name 'META-INF' -o -name '.cache' -o -name 'env' -o -name 'target' \) -prune \
    -o \
    -type f \( ! -name '*.png' ! -name '*.pdf' ! -name '*.epub' ! -name '*.zip' ! -name '*.db' ! -name '*.class' \) -print |
    sed "s|^\./||" |
    fzf --prompt="Select file: ")

# 2. Check if file was selected
if [ -n "$file" ]; then
    # WezTerm automatically names tabs based on the running process (nvim),
    # but if you want to force the title explicitly, use this escape sequence:
    printf "\033]0;nvim\007"

    # Open nvim
    nvim "$file"
fi
