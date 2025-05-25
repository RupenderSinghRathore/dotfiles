if tmux list-windows -F '#I' | grep -q '^9$'; then tmux select-window -t :=9; else tmux select-window -t :=$(tmux list-windows -F '#I' | tail -n 1); fi
