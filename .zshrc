export ZSH="$HOME/.oh-my-zsh"
setopt IGNOREEOF
setopt autocd
export PATH="$HOME/.local/bin:$HOME/.local/omarchy/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH"
export MANPAGER='nvim +Man!'
export GTK_USE_PORTAL=0
export GREENLIGHT_DB_DSN='postgres://greenlight:touka@localhost/greenlight?sslmode=disable'


export KRAFTKIT_LOG_LEVEL=debug
export KRAFTKIT_LOG_TYPE=basic


export QT_QPA_PLATFORMTHEME=qt6ct

# export RUST_BACKTRACE=1
# typeset -U PATH # remove duplication from path

export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

# setopt ignoreeof
# IGNOREEOF=10

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
eval "$(starship init zsh)"

export EDITOR='nvim'
export SUDO_EDITOR="nvim"

# CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true" # Case-sensitive completion must be off. _ and - will be interchangeable.

# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder # just remind me to update when it's time

plugins=(git web-search zsh-syntax-highlighting zsh-vi-mode zsh-autosuggestions)
# plugins=(git web-search zsh-syntax-highlighting zsh-autosuggestions zsh-system-clipboard)
# plugins=(git web-search zsh-syntax-highlighting zsh-autosuggestions)

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZVM_CURSOR_STYLE_ENABLED=false
ZSH_WEB_SEARCH_ENGINES=(
    bigo "https://www.bigocalc.com/"
)

source $ZSH/oh-my-zsh.sh

mycd() {
    local search_dirs=(~/dotfiles ~/lunaar ~/Documents ~/Downloads ~/lunaar/languages/go ~/Notes)

    local dir=$(
        command fd '' "${search_dirs[@]}" \
            --type d \
            --max-depth 2 \
            --hidden \
            --no-ignore \
            --exclude .git \
            --exclude .cache \
            --exclude .obsidian \
            --absolute-path 2>/dev/null |
            sed "s|^$HOME/||" |
            fzf --height 40% --reverse --prompt="Select directory: "
    )

    if [ -n "$dir" ]; then
        cd "$HOME/$dir" && clear || echo "error opening directory"
    fi
}
web-dow() {
    wget --mirror \
        --convert-links \
        --adjust-extension \
        --page-requisites \
        --no-parent \
        -U "Mozilla/5.0 (compatible; MyOfflineBot/1.0)" \
        ${1}
}
launch() {
    "$2" --class "$1" -e "$1" || echo "Use: launch nvim kitty/alacritty"
}
makec() {
    ./make.sh "$@"
}
rustp() {
    cargo new ${1} && cd ${1} || return 1
    nvim ./src/main.rc
}
npipe() {
    nvim $(which $1)
}
py() {
    source ${1}.venv/bin/activate
}
mdc() {
    mkdir -p "$1" && cd "$1"
}
alopacity() {
    alacritty msg config window.opacity="$1"
}
top-bar-toggle() {
    mv ~/dotfiles/.config/DankMaterialShell/settings.json ~/dotfiles/.config/DankMaterialShell/temp && mv ~/dotfiles/.config/DankMaterialShell/toggle.json ~/dotfiles/.config/DankMaterialShell/settings.json && mv ~/dotfiles/.config/DankMaterialShell/temp ~/dotfiles/.config/DankMaterialShell/toggle.json && dms restart
}
help() {
    "$@" --help | bat -l man
}
docker-latest() {
    docker build . -t "$1:$2" -t "$1:latest"
}

# Generated for envman. Do not edit.
# [ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# . "$HOME/.local/share/../bin/env"

# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.

# bindkey -v
# bindkey -a '^H' backward-kill-word # vi command mode
# bindkey -v '^H' backward-kill-word
# bindkey '^H' backward-kill-word
# bindkey '^?' backward-kill-word

# set -o vi
# bindkey -M viins '^e' autosuggest-accept

precmd() {print -Pn "\e]0;%~\a"}
DISABLE_AUTO_TITLE="true"
source ~/dotfiles/.config/zsh/aliases
# source ~/dotfiles/.config/zsh/api-keys.sh

function set_cursor() {
  printf '\e[2 q'   # steady block (no blink)
}

precmd_functions+=(set_cursor)

