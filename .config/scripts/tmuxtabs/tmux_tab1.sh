if tmux list-windows -F '#I' | grep -q '^1$'; then tmux select-window -t :=1; else tmux select-window -t :=$(tmux list-windows -F '#I' | tail -n 1); fi
