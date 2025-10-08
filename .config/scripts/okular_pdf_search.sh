#!/bin/bash

search_dirs=("$HOME/Downloads" "$HOME/Documents")

# Find files
mapfile -t files < <(find "${search_dirs[@]}" -type f \( -iname '*.pdf' -o -iname '*.epub' -o -iname '*.pptx' -o -iname '*.docx' \) -print 2>/dev/null)

# Exit if no files found
[ ${#files[@]} -eq 0 ] && exit 0

# Build display list (two dirs before file)
display_list=()
for f in "${files[@]}"; do
    rel="${f#$HOME/}" # strip $HOME prefix
    # Keep last 3 components (two dirs + file)
    # short=$(echo "$rel" | awk -F/ '{print $(NF-2)"/"$(NF-1)"/"$NF}')
    # display_list+=("$(basename "$f")")
    display_list+=("$rel")
done

# Let user choose from Rofi
chosen_short=$(
    printf '%s\n' "${display_list[@]}" |
        # rofi -dmenu -i -p -normal-window "Select file:"
        rofi -normal-window -dmenu -i -p "Select file:" -theme "$HOME/dotfiles/.config/rofi/config-okular.rasi"
)

# Exit if no selection
[ -z "$chosen_short" ] && exit 0

# Match selection back to full path
for i in "${!display_list[@]}"; do
    if [[ "${display_list[$i]}" == "$chosen_short" ]]; then
        okular "${files[$i]}" 2>/dev/null &
        break
    fi
done
