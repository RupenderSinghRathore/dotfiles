if tmux list-windows -F '#I' | grep -q '^3$'; then tmux select-window -t :=3; else tmux select-window -t :=$(tmux list-windows -F '#I' | tail -n 1); fi
