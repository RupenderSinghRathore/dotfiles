#!/bin/bash

file=$(fzf --prompt="Select file: ")
[ -n "$file" ] && nvim "$file"
