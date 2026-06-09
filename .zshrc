export ZSH="$HOME/.oh-my-zsh"
setopt IGNOREEOF
setopt autocd
export PATH="$HOME/.local/bin:$HOME/.local/omarchy/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH"
export MANPAGER='nvim +Man!'
export GTK_USE_PORTAL=0
export GREENLIGHT_DB_DSN='postgres://greenlight:touka@localhost/greenlight?sslmode=disable'

export XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"

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

# - $ZSH_CUSTOM/aliases.zsh
source ~/dotfiles/.config/zsh/aliases
source ~/dotfiles/.config/zsh/functions
# source ~/dotfiles/.config/zsh/api-keys.sh

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

# Generated for envman. Do not edit.
# [ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# . "$HOME/.local/share/../bin/env"

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

# function set_cursor() {
#     printf '\e[2 q' # steady block (no blink)
# }

# precmd_functions+=(set_cursor)

# block cursor
# echo -ne '\e[2 q'

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/kami-sama/.lmstudio/bin"
# End of LM Studio CLI section

