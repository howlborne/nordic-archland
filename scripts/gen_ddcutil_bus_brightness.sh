#!/usr/bin/env bash
set -euo pipefail

THEMES=$HOME/.local/share/archland/global-themes

OUT_0="/tmp/brightness.sh"
OUT_1="/tmp/hypridle_ddcutil.sh"

BUS=$(ddcutil detect | grep -o 'i2c-[0-9]*' | cut -d- -f2 | head -n1)

if [[ -z "$BUS" ]]; then
    echo "Error: could not detect DDC bus" >&2
    exit 1
fi

cat > "$OUT_0" <<EOF
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

chmod +x "$OUT_0"

cp /tmp/brightness.sh $THEMES/golden-harvest/.config/waybar/scripts/
cp /tmp/brightness.sh $THEMES/nordveil/.config/waybar/scripts/

cat > "$OUT_1" <<EOF
#!/usr/bin/env bash

stored_ddc_value=\$(< \$HOME/.config/hypr/hypridle/ddcutil/getvcp)
current_ddc_value=\$(ddcutil --bus=1 getvcp 0x10 2>/dev/null | grep -oP 'current value =\s*\K\d+')

case "\$1" in
    'store')
        ddcutil --bus=$BUS getvcp 0x10 2>/dev/null | grep -oP 'current value =\\s*\\K\\d+' > \$HOME/.config/hypr/hypridle/ddcutil/getvcp
        ;;
    'set')
        if [ "\$current_ddc_value" -ge 10 ]; then
            ddcutil --bus=$BUS setvcp 0x10 - 10
        elif [ "\$current_ddc_value" -lt 10 ]; then
            ddcutil --bus=$BUS setvcp 0x10 0
        fi
        pkill -RTMIN+18 waybar
        ;;
    'restore')
        ddcutil --bus=$BUS setvcp 0x10 \$stored_ddc_value
        pkill -RTMIN+18 waybar
        ;;
esac
EOF

chmod +x "$OUT_1"
sudo mv /tmp/hypridle_ddcutil.sh /usr/local/bin

echo "Script generated at: $OUT_0 (BUS=$BUS)"

if ! grep -q "XF86MonBrightnessUp, exec, ddcutil" "$THEMES/nordveil/.config/hypr/keybinds.conf"; then
    sed -i "/XF86AudioMicMute/a\
bindel = ,XF86MonBrightnessUp, exec, ddcutil --bus=${BUS} setvcp 0x10 + 5; pkill -RTMIN+18 waybar\n\
bindel = ,XF86MonBrightnessDown, exec, ddcutil --bus=${BUS} setvcp 0x10 - 5; pkill -RTMIN+18 waybar" \
"$THEMES/nordveil/.config/hypr/keybinds.conf"
fi

if ! grep -q "XF86MonBrightnessUp, exec, ddcutil" "$THEMES/golden-harvest/.config/hypr/keybinds.conf"; then
    sed -i "/XF86AudioMicMute/a\
bindel = ,XF86MonBrightnessUp, exec, ddcutil --bus=${BUS} setvcp 0x10 + 5; pkill -RTMIN+18 waybar\n\
bindel = ,XF86MonBrightnessDown, exec, ddcutil --bus=${BUS} setvcp 0x10 - 5; pkill -RTMIN+18 waybar" \
"$THEMES/golden-harvest/.config/hypr/keybinds.conf"
fi

