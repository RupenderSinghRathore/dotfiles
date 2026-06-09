function mycd
    set search_dirs \
        ~/dotfiles \
        ~/lunaar \
        ~/Documents \
        ~/Downloads \
        ~/lunaar/languages/go \
        ~/Notes

    set dir (
        fd '' $search_dirs \
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

    if test -n "$dir"
        cd "$HOME/$dir"; and clear
        or echo "error opening directory"
    end
end

function web-dow
    wget --mirror \
        --convert-links \
        --adjust-extension \
        --page-requisites \
        --no-parent \
        -U "Mozilla/5.0 (compatible; MyOfflineBot/1.0)" \
        $argv[1]
end

function launch
    $argv[2] --class $argv[1] -e $argv[1]
    or echo "Use: launch nvim kitty/alacritty"
end

function makec
    ./make.sh $argv
end

function rustp
    cargo new $argv[1]
    and cd $argv[1]
    or return 1

    nvim ./src/main.rs
end

function npipe
    nvim (which $argv[1])
end

function py
    source $argv[1].venv/bin/activate.fish
end

function mdc
    mkdir -p $argv[1]
    and cd $argv[1]
end

function alopacity
    alacritty msg config window.opacity="$argv[1]"
end

function help
    $argv --help | bat -l man
end

function docker-latest
    docker build . \
        -t "$argv[1]:$argv[2]" \
        -t "$argv[1]:latest"
end

function clippy
    cargo clippy $argv -- -W clippy::all -W clippy::pedantic
end
