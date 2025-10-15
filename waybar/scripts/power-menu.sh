#!/usr/bin/env bash

list="Lock\nShutdown\nReboot\nLogout\nHibernate\nSuspend"

selected=$(echo -e "$list" | rofi -dmenu -i -p "Power Menu")

[[ -z $selected ]] && exit 0

case "$selected" in
    'Lock') hyprlock ;;  # or swaylock, depending on what you use
    'Shutdown') systemctl poweroff ;;
    'Reboot') systemctl reboot ;;
    'Logout') loginctl terminate-session "$XDG_SESSION_ID" ;;
    'Hibernate') systemctl hibernate ;;
    'Suspend') systemctl suspend ;;
esac
