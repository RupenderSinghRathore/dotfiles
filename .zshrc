# source ~/dotfiles/.config/zsh/private-env

export ZSH="$HOME/.oh-my-zsh"
setopt IGNOREEOF
setopt autocd
export PATH="$HOME/.local/bin:$HOME/.local/omarchy/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH"
export MANPAGER='nvim +Man!'
export GTK_USE_PORTAL=1
typeset -U PATH # remove duplication from path

# export QT_QPA_PLATFORMTHEME=qt5ct
# export QT_QPA_PLATFORMTHEME=qt6ct
# export QT_STYLE_OVERRIDE=Kvantum
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

# setopt ignoreeof
# IGNOREEOF=10

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
eval "$(starship init zsh)"

export EDITOR='nvim'

# CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true" # Case-sensitive completion must be off. _ and - will be interchangeable.

# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder # just remind me to update when it's time

plugins=(git web-search zsh-syntax-highlighting zsh-vi-mode zsh-autosuggestions)
ZVM_CURSOR_STYLE_ENABLED=false
ZSH_WEB_SEARCH_ENGINES=(
    bigo "https://www.bigocalc.com/"
)

source $ZSH/oh-my-zsh.sh

mycd() {
    local dir
    search_dirs=(~/dotfiles ~/lunaar ~/Documents ~/Downloads)
    dir=$(
        find "${search_dirs[@]}" -type d \
            \( -name '.git' -o -name 'themes' -o -name '.venv' -o -name 'node_modules' -o -name '.gradle' -o -name 'META-INF' \) -prune \
            -o -type d -print 2>/dev/null |
            sed "s|^$HOME/||" |
            fzf --prompt="Select directory: "
    )
    if [ -n "$dir" ]; then
        cd "$HOME/$dir" || echo "error opening directory"
    fi
}
makec() {
    ./make.sh "$@"
}
npipe() {
    nvim $(which $1)
}

# Generated for envman. Do not edit.
# [ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# . "$HOME/.local/share/../bin/env"

# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
source ~/dotfiles/.config/zsh/aliases
