if tmux list-windows -F '#I' | grep -q '^8$'; then tmux select-window -t :=8; else tmux select-window -t :=$(tmux list-windows -F '#I' | tail -n 1); fi
