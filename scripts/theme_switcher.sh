#!/usr/bin/env bash

# Author: howlborne <github.com/howlborne>

THEMES="$HOME/.local/share/archland/global-themes"

options=$(
cat <<EOF
󰞹  Golden Harvest
󰼶  Nordveil
EOF
)

selected="$(printf '%s\n' "$options" | rofi -dmenu -i \
  -p "Select Theme" \
  -mesg $'⚠ WARNING:\nHyprland will restart! Save your work!\nPress Esc to close.')"

[ -z "$selected" ] && exit 0

case "$selected" in
    *Golden\ Harvest*) "$THEMES/scripts/golden_harvest.sh" ;;
    *Nordveil*)        "$THEMES/scripts/nordveil.sh" ;;
esac
