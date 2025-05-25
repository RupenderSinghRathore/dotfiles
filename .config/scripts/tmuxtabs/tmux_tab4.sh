if tmux list-windows -F '#I' | grep -q '^4$'; then tmux select-window -t :=4; else tmux select-window -t :=$(tmux list-windows -F '#I' | tail -n 1); fi
