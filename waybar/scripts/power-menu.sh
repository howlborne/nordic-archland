#!/usr/bin/env bash

options=$(
cat <<EOF
󰌾  Lock
󰐥  Shutdown
󰜉  Reboot
󰗼  Logout
󰒲  Hibernate
󰤄  Suspend
EOF
)

selected="$(printf '%s\n' "$options" | rofi -dmenu -i -p "Power")"
[ -z "$selected" ] && exit 0

case "$selected" in
    *Lock*)        hyprlock ;;
    *Shutdown*)    systemctl poweroff ;;
    *Reboot*)      systemctl reboot ;;
    *Logout*)      loginctl terminate-session "$XDG_SESSION_ID" ;;
    *Hibernate*)   systemctl hibernate ;;
    *Suspend*)     systemctl suspend ;;
esac
