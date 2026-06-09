# source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# Environment variables

set -gx ZSH "$HOME/.oh-my-zsh"

set -g fish_greeting 
# if status is-interactive 
# end

# fish_ignoreeof 1
# setopt IGNOREEOF

set -gx PATH \
    $HOME/.local/bin \
    $HOME/.local/omarchy/bin \
    $HOME/go/bin \
    $HOME/.cargo/bin \
    $PATH

set -gx MANPAGER 'nvim +Man!'
set -gx GTK_USE_PORTAL 0

# set -gx GREENLIGHT_DB_DSN \
#     'postgres://greenlight:touka@localhost/greenlight?sslmode=disable'

set -gx XDG_DATA_DIRS \
    "$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"

# set -gx KRAFTKIT_LOG_LEVEL debug
# set -gx KRAFTKIT_LOG_TYPE basic

set -gx QT_QPA_PLATFORMTHEME qt6ct

# set -gx RUST_BACKTRACE 1

set -gx DEBUGINFOD_URLS "https://debuginfod.archlinux.org"

set -gx EDITOR nvim
set -gx SUDO_EDITOR nvim

set -gx HYPHEN_INSENSITIVE true

# Starship
starship init fish | source

# Source aliases/functions
source ~/dotfiles/.config/fish/aliases.fish
source ~/dotfiles/.config/fish/functions.fish

# Window title
# function fish_title
#     echo (prompt_pwd)
# end
