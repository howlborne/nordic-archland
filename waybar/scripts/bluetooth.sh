#!/usr/bin/env bash

# Bluetooth menu using bluetoothctl, fzf, and Alacritty
# Author: Refactored by ChatGPT for terminal-based interaction
# License: MIT

# Constants
BUSY_ICON=''
SCAN_TIMEOUT=10
TERM_CMD="alacritty -e"  # Change this if you use another terminal

# Turn on Bluetooth if off
status=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')
if [[ $status == "no" ]]; then
    bluetoothctl power on >/dev/null
    notify-send "Bluetooth" "Powered On" -i "$BUSY_ICON" -r 1925
fi

# Scan for devices
bluetoothctl --timeout $SCAN_TIMEOUT scan on >/dev/null &
sleep "$SCAN_TIMEOUT"

# List devices: MAC + Name
device_list=$(bluetoothctl devices | grep ^Device | while read -r _ mac_and_name; do
    mac=$(echo "$mac_and_name" | awk '{print $1}')
    name_from_list=$(echo "$mac_and_name" | cut -d' ' -f2-)
    name_from_info=$(bluetoothctl info "$mac" | grep "Name:" | cut -d' ' -f2-)
    display_name="${name_from_info:-$name_from_list}"
    echo "$mac $display_name"
done)

# Check if device list is empty
if [[ -z "$device_list" ]]; then
    notify-send "Bluetooth" "No devices found." -i "$BUSY_ICON"
    exit 1
fi

# Use fzf to select a device
selected_device=$(echo "$device_list" | fzf --prompt="Select Device: ")

# Exit if nothing selected
[[ -z "$selected_device" ]] && exit 0

# Extract MAC and Name
mac=$(echo "$selected_device" | awk '{print $1}')
name=$(echo "$selected_device" | cut -d' ' -f2-)

# Show action menu for selected device
action=$(printf "Connect\nDisconnect\nInfo" | fzf --prompt="Action for $mac: ")

# Exit if no action selected
[[ -z "$action" ]] && exit 0

# Perform selected action
case "$action" in
    "Info")
        $TERM_CMD bash -c "bluetoothctl info '$mac' | less"
        ;;

    "Connect")
        connected=$(bluetoothctl info "$mac" | grep "Connected:" | awk '{print $2}')
        if [[ $connected == "yes" ]]; then
            notify-send "Bluetooth" "Already connected to $name" -i "$BUSY_ICON"
            exit 0
        fi

        paired=$(bluetoothctl info "$mac" | grep "Paired:" | awk '{print $2}')
        if [[ $paired == "no" ]]; then
            notify-send "Bluetooth" "Pairing with $name..." -i "$BUSY_ICON"
            if ! timeout 10 bluetoothctl pair "$mac" >/dev/null; then
                notify-send "Bluetooth" "Failed to pair with $name" -i "$BUSY_ICON"
                exit 1
            fi
        fi

        # Trust the device after pairing (or just in case it's not trusted)
        trusted=$(bluetoothctl info "$mac" | grep "Trusted:" | awk '{print $2}')
        if [[ $trusted == "no" ]]; then
            notify-send "Bluetooth" "Trusting $name..." -i "$BUSY_ICON"
            bluetoothctl trust "$mac" >/dev/null
        fi

        notify-send "Bluetooth" "Connecting to $name..." -i "$BUSY_ICON"
        if timeout 10 bluetoothctl connect "$mac" >/dev/null; then
            notify-send "Bluetooth" "Connected to $name" -i "$BUSY_ICON"
        else
            notify-send "Bluetooth" "Failed to connect to $name" -i "$BUSY_ICON"
        fi
        ;;

    "Disconnect")
        connected=$(bluetoothctl info "$mac" | grep "Connected:" | awk '{print $2}')
        if [[ $connected == "yes" ]]; then
            notify-send "Bluetooth" "Disconnecting from $name..." -i "$BUSY_ICON"
            bluetoothctl disconnect "$mac" >/dev/null
            notify-send "Bluetooth" "Disconnected from $name" -i "$BUSY_ICON"
        else
            notify-send "Bluetooth" "$name is not connected" -i "$BUSY_ICON"
        fi
        ;;
esac
