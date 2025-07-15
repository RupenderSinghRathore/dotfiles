kill_tmux_window_widget() {
  BUFFER="tmux kill-window"  # The command to run
  zle accept-line          # Execute the command
}
create_tmux_window_widget() {
    BUFFER="tmux new-window -c \"#{pane_current_path}\""
    zle accept-line
}
tmux_tab_1() {
    BUFFER="tmux select-window -t :=1 || tmux select-window -t :$({tmux list-windows -F '#{window_index}' | sort -nr | head -n 1})"
    zle accept-line
}
tmux_tab_2() {
    BUFFER="tmux select-window -t :=2 || tmux select-window -t :$({tmux list-windows -F '#{window_index}' | sort -nr | head -n 1})"
    zle accept-line
}
tmux_tab_3() {
    BUFFER="tmux select-window -t :=3 || tmux select-window -t :$({tmux list-windows -F '#{window_index}' | sort -nr | head -n 1})"
    zle accept-line
}
tmux_tab_4() {
    BUFFER="tmux select-window -t :=4 || tmux select-window -t :$({tmux list-windows -F '#{window_index}' | sort -nr | head -n 1})"
    zle accept-line
}
tmux_tab_5() {
    BUFFER="tmux select-window -t :=5 || tmux select-window -t :$({tmux list-windows -F '#{window_index}' | sort -nr | head -n 1})"
    zle accept-line
}
tmux_tab_6() {
    BUFFER="tmux select-window -t :=6 || tmux select-window -t :$({tmux list-windows -F '#{window_index}' | sort -nr | head -n 1})"
    zle accept-line
}
tmux_tab_7() {
    BUFFER="tmux select-window -t :=7 || tmux select-window -t :$({tmux list-windows -F '#{window_index}' | sort -nr | head -n 1})"
    zle accept-line
}
tmux_tab_8() {
    BUFFER="tmux select-window -t :=8 || tmux select-window -t :$({tmux list-windows -F '#{window_index}' | sort -nr | head -n 1})"
    zle accept-line
}
tmux_tab_9() {
    BUFFER="tmux select-window -t :=9 || tmux select-window -t :$({tmux list-windows -F '#{window_index}' | sort -nr | head -n 1})"
    zle accept-line
}

# Register the function as a ZLE widget
zle -N kill_tmux_window_widget
zle -N create_tmux_window_widget
zle -N tmux_tab_1
zle -N tmux_tab_2
zle -N tmux_tab_3
zle -N tmux_tab_4
zle -N tmux_tab_5
zle -N tmux_tab_6
zle -N tmux_tab_7
zle -N tmux_tab_8
zle -N tmux_tab_9

# Bind Ctrl+Shift+G to the kill_tmux_window_widget
# REPLACE 'YOUR_CTRL_SHIFT_G_SEQUENCE' with what you found in step 1
bindkey '^W' kill_tmux_window_widget
bindkey '^T' create_tmux_window_widget
# bindkey '1' tmux_tab_1
# bindkey '2' tmux_tab_2
# bindkey '^3' tmux_tab_3
# bindkey '^4' tmux_tab_4
# bindkey '^5' tmux_tab_5
# bindkey '^6' tmux_tab_6
# bindkey '^7' tmux_tab_7
# bindkey '^8' tmux_tab_8
# bindkey '^9' tmux_tab_9
