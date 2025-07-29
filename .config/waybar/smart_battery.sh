#!/bin/bash

BAT_PATH="/sys/class/power_supply/BAT0"

last_level=-1
last_status=""
low_battery=40
hi_battery=85

send_json() {
    echo "{\"text\": \"$1\", \"tooltip\": \"$2\", \"class\": \"$3\"}"
}

while true; do
    level=$(cat "$BAT_PATH/capacity")
    status=$(cat "$BAT_PATH/status")

    if [[ "$level" != "$last_level" || "$status" != "$last_status" ]]; then
        icon=""
        if [[ $level -ge 90 ]]; then
            icon=""
        elif [[ $level -ge 70 ]]; then
            icon=""
        elif [[ $level -ge 50 ]]; then
            icon=""
        elif [[ $level -ge 30 ]]; then icon=""; fi

        if [[ "$status" == "Charging" ]]; then
            icon=""
            fg="#B1E3AD"
            class="charging"
            text="<span size='13000' foreground='$fg'>$icon </span>${level}%"
        elif [[ "$status" == "Full" ]]; then
            icon=""
            fg="#B1E3AD"
            class="full"
            text="<span size='13000' foreground='$fg'>$icon </span>${level}%"
        elif [[ $level -le 15 ]]; then
            fg="#FF3131"
            class="critical"
            text="<span size='13000' foreground='$fg'>$icon </span>${level}%"
        elif [[ $level -le 30 ]]; then
            fg="#FFA500"
            class="warning"
            text="<span size='13000' foreground='$fg'>$icon </span>${level}%"
        else
            fg="#a6e3a1"
            class="normal"
            text="<span size='13000' foreground='$fg'>$icon </span>${level}%"
        fi

        send_json "$text" "Status: $status" "$class"

        # Optional: notify on low battery
        if [[ $level -le $low_battery && "$status" == "Discharging" ]]; then
            notify-send -u critical -i battery-caution-symbolic "⚡ Battery Low!" "Battery at ${level}% - Connect charger!"
            paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga &
        elif [[ $level -ge $hi_battery && $status == "Charging" ]]; then
            notify-send -u critical -i battery-caution-symbolic "⚡ Battery overflow!" "Battery at ${battery_level}% - Disconnect charger!" && paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
        fi

        last_level=$level
        last_status=$status
    fi

    inotifywait -e modify "$BAT_PATH/capacity" "$BAT_PATH/status" >/dev/null 2>&1
done
