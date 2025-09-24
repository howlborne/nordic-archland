#!/usr/bin/env bash

# Set your monitor's DDC bus here (replace 6 with yours)
BUS=6

case "$1" in
    'get')
        ddcutil --bus=$BUS getvcp 0x10 2>/dev/null | grep -oP 'current value =\s*\K\d+' || echo "?"
        pkill -RTMIN+18 waybar
        ;;
    'up')
        ddcutil --bus=$BUS setvcp 0x10 + 5
        pkill -RTMIN+18 waybar
        ;;
    'down')
        ddcutil --bus=$BUS setvcp 0x10 - 5
        pkill -RTMIN+18 waybar
        ;;
    'left_click')
        ddcutil --bus=$BUS setvcp 0x10 100
        pkill -RTMIN+18 waybar
        ;;
    'right_click')
        ddcutil --bus=$BUS setvcp 0x10 0
        pkill -RTMIN+18 waybar
        ;;
esac

# Show notification
# notify-send "Brightness: $level%" -h int:value:"$level" -i 'display-brightness' -r 2825
