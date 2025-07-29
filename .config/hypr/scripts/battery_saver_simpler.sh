#!/bin/bash

THRESHOLD1=30
THRESHOLD2=85

while true; do
    battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
    battery_state=$(cat /sys/class/power_supply/BAT0/status)
    if [[ "$battery_state" == "Discharging" ]] && [[ "$battery_level" -le $THRESHOLD1 ]]; then
        notify-send -u critical -i battery-caution-symbolic "⚡ Battery Low!" "Battery at ${battery_level}% - Connect charger!" && paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
    elif [[ "$battery_state" == "Charging" ]] && [[ "$battery_level" -ge $THRESHOLD2 ]]; then
        notify-send -u critical -i battery-caution-symbolic "⚡ Battery overflow!" "Battery at ${battery_level}% - Disconnect charger!" && paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
    fi

    sleep 300
done
