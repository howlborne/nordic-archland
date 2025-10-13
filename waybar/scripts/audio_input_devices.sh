#!/usr/bin/env bash

# List input devices (sources) in format: index name
devices=$(pactl list short sources | awk '{print $1 " " $2}')

# Use rofi to select a device
selected=$(echo "$devices" | rofi -dmenu -p "Select audio input device:" | awk '{print $1}')

if [[ -n "$selected" ]]; then
    pactl set-default-source "$selected"
    notify-send "Input device set to" "$selected"
else
    notify-send "Input device selection cancelled"
fi

