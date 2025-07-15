#!/bin/bash

THRESHOLD1=30
THRESHOLD2=85

while true; do
    battery_info=$(upower -i $(upower -e | grep BAT) 2>/dev/null)
    battery_level=$(echo "$battery_info" | awk '/percentage/ {print $2}' | tr -d '%')
    battery_state=$(echo "$battery_info" | awk '/state/ {print $2}')

    # Default to 100 if upower fails
    battery_level=${battery_level:-100}

    if [[ "$battery_state" == "discharging" ]] && [[ "$battery_level" -le $THRESHOLD1 ]]; then
        notify-send -u critical "⚡ Battery Low!" "Battery at ${battery_level}% - Connect charger!"
        paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
    elif [[ "$battery_state" == "charging" ]] && [[ "$battery_level" -ge $THRESHOLD2 ]]; then
        notify-send -u critical "⚡ Battery overflow!" "Battery at ${battery_level}% - Disconnect charger!"
        paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
    fi

    sleep 300
done
