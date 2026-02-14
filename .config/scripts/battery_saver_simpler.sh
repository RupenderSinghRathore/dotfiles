#!/bin/bash

THRESHOLD1=30
THRESHOLD2=80
SLEEP_TIME=60

BAT_PATH="/sys/class/power_supply/BAT0"
if [ ! -d "$BAT_PATH" ]; then
    BAT_PATH="/sys/class/power_supply/BAT1"
fi

while true; do
    # Read values with defaults to prevent empty variable crashes
    battery_level=$(cat "$BAT_PATH/capacity" 2>/dev/null || echo 0)
    battery_state=$(cat "$BAT_PATH/status" 2>/dev/null || echo "Unknown")

    # Ensure level is treated as a number
    if ! [[ "$battery_level" =~ ^[0-9]+$ ]]; then
        sleep 5
        continue
    fi

    if [[ "$battery_state" == "Discharging" ]] && [[ "$battery_level" -le $THRESHOLD1 ]]; then
        notify-send -a "Battery" -u critical -i battery-caution "⚡ Battery Low!" "      ${battery_level}%" ; paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
    
    elif [[ "$battery_state" == "Charging" ]] && [[ "$battery_level" -ge $THRESHOLD2 ]]; then
        notify-send -a "Battery" -u critical -i battery-full "⚡ Battery overflow!" "      ${battery_level}%" ; paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
    fi

    sleep $SLEEP_TIME
done
