#!/bin/bash

options=" Poweroff\n Reboot\n Lock\n⏾ Suspend\n Logout"
chosen=$(echo -e "$options" | rofi -dmenu -p "Power Menu")

case "$chosen" in
" Poweroff") systemctl poweroff ;;
" Reboot") systemctl reboot ;;
" Lock") hyprlock ;;
"⏾ Suspend") systemctl suspend ;;
" Logout") hyprctl dispatch exit ;;
esac
