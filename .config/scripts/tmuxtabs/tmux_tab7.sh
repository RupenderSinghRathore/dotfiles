if tmux list-windows -F '#I' | grep -q '^7$'; then tmux select-window -t :=7; else tmux select-window -t :=$(tmux list-windows -F '#I' | tail -n 1); fi
