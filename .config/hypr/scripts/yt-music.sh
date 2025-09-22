#!/bin/bash

# Find Chromium's sink input ID
ID=$(pactl list sink-inputs | awk '/Sink Input #/{id=$3} /application.name = "Chromium"/{gsub("#","",id); print id}')

# If we found Chromium's ID, increase its volume
if [ -n "$ID" ]; then
    if [ "$1" = "+" ]; then
        pactl set-sink-input-volume "$ID" +5%
    elif [ "$1" = "-" ]; then
        pactl set-sink-input-volume "$ID" -5%
    else
        echo "Usage: $0 [+|-]"
    fi
else
    echo "No Chromium audio stream found."
fi
