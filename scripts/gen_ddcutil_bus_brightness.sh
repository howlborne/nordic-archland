#!/usr/bin/env bash
set -euo pipefail

OUT="$HOME/.config/waybar/scripts/brightness.sh"

BUS=$(ddcutil detect | grep -o 'i2c-[0-9]*' | cut -d- -f2 | head -n1)

if [[ -z "$BUS" ]]; then
    echo "Error: could not detect DDC bus" >&2
    exit 1
fi

cat > "$OUT" <<EOF
#!/usr/bin/env bash

BUS=$BUS

case "\$1" in
    'get')
        ddcutil --bus=\$BUS getvcp 0x10 2>/dev/null | grep -oP 'current value =\\s*\\K\\d+' || echo "?"
        ;;
    'up')
        ddcutil --bus=\$BUS setvcp 0x10 + 5
        pkill -RTMIN+18 waybar
        ;;
    'down')
        ddcutil --bus=\$BUS setvcp 0x10 - 5
        pkill -RTMIN+18 waybar
        ;;
    'left_click')
        ddcutil --bus=\$BUS setvcp 0x10 100
        pkill -RTMIN+18 waybar
        ;;
    'right_click')
        ddcutil --bus=\$BUS setvcp 0x10 0
        pkill -RTMIN+18 waybar
        ;;
esac
EOF

chmod +x "$OUT"

echo "Script generated at: $OUT (BUS=$BUS)"

sed -i "/XF86AudioMicMute/a\
bindel = ,XF86MonBrightnessUp, exec, ddcutil --bus=${BUS} setvcp 0x10 + 5; pkill -RTMIN+18 waybar\n\
bindel = ,XF86MonBrightnessDown, exec, ddcutil --bus=${BUS} setvcp 0x10 - 5; pkill -RTMIN+18 waybar" \
~/.config/hypr/keybinds.conf

