#!/usr/bin/env bash

# Wi-Fi Manager using nmcli + fzf
# Author: howlborne + ChatGPT
# Requirements: nmcli, fzf, notify-send
# Launch with: kitty -e ~/scripts/wifi_fzf.sh

WIFI_ICON=''
SCAN_TIMEOUT=5

# Enable Wi-Fi if off
if [[ $(nmcli radio wifi) == 'disabled' ]]; then
    nmcli radio wifi on
    notify-send 'Wi-Fi' 'Enabled' -i "$WIFI_ICON"
fi

# Start scan in background
nmcli device wifi rescan >/dev/null 2>&1 &
sleep 1

# Wait up to SCAN_TIMEOUT for networks
for ((i = 1; i <= SCAN_TIMEOUT; i++)); do
    output=$(nmcli -f SSID,SECURITY,SIGNAL device wifi list --rescan no)
    list=$(tail -n +2 <<<"$output" | awk '$1 != ""')
    [[ -n $list ]] && break
    sleep 1
done

if [[ -z $list ]]; then
    notify-send 'Wi-Fi' 'No networks found' -i "$WIFI_ICON"
    exit 1
fi

# Use a safe delimiter
formatted=$(echo "$list" | awk '{printf "%s:::%s:::%s\n", $1, $2, $3}')
selection=$(echo "$formatted" | fzf --delimiter=":::" --with-nth=1,2,3 \
    --preview='echo -e "SSID: {1}\nSecurity: {2}\nSignal: {3}"' \
    --prompt="Wi-Fi Networks > " --height=20 --reverse)

[[ -z $selection ]] && exit 0

# Extract SSID from selection
ssid=$(echo "$selection" | cut -d':' -f1)

# Determine connection state
active_ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
known_connections=$(nmcli connection show | awk '{print $1}' | grep -Fx "$ssid")

# Build action list dynamically
actions=()
if [[ "$ssid" == "$active_ssid" ]]; then
    actions+=("Disconnect")
fi
if [[ -n "$known_connections" ]]; then
    actions+=("Forget")
fi
actions+=("Connect")
actions+=("More Info")

# Choose action
action=$(printf "%s\n" "${actions[@]}" | fzf --prompt="Action for '$ssid' > " --reverse --height=10)

[[ -z $action ]] && exit 0

# Handle action
case "$action" in
    "Connect")
        notify-send 'Wi-Fi' "Connecting to '$ssid'..." -i "$WIFI_ICON"
        if nmcli device wifi connect "$ssid" --ask; then
            notify-send 'Wi-Fi' "Connected to '$ssid'" -i "$WIFI_ICON"
        else
            notify-send 'Wi-Fi' "Failed to connect to '$ssid'" -i "$WIFI_ICON"
        fi
        ;;
    "Disconnect")
        nmcli connection down "$ssid"
        notify-send 'Wi-Fi' "Disconnected from '$ssid'" -i "$WIFI_ICON"
        ;;
    "Forget")
        nmcli connection delete "$ssid"
        notify-send 'Wi-Fi' "Forgotten network '$ssid'" -i "$WIFI_ICON"
        ;;
    "More Info")
        info=$(nmcli -f all device wifi list | grep -A 5 "$ssid")
        echo -e "Details for $ssid:\n\n$info"
        read -n 1 -s -r -p "Press any key to exit..."
        ;;
esac
