if tmux list-windows -F '#I' | grep -q '^2$'; then tmux select-window -t :=2; else tmux select-window -t :=$(tmux list-windows -F '#I' | tail -n 1); fi
