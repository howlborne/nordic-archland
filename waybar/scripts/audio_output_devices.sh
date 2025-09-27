#!/usr/bin/env bash

devices=$(pactl list short sinks | awk '{print $1 " " $2}')

selected=$(echo "$devices" | rofi -dmenu -p "Select output device:" | awk '{print $1}')

if [[ -n "$selected" ]]; then
    pactl set-default-sink "$selected"
    notify-send "Output device set to" "$selected"
else
    notify-send "Output device selection cancelled"
fi

