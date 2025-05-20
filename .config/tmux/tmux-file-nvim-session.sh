#!/bin/zsh

file=$(fzf --prompt="Select file: ")
[ -n "$file" ] && nvim "$file"
