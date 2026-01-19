#!/usr/bin/env bash
set -euo pipefail

OUT_0="$HOME/.config/waybar/scripts/brightness.sh"
OUT_1="$HOME/.config/hypr/hypridle_ddcutil.sh"

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

mkdir -p $HOME/.config/hypr/hypridle/ddcutil

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
sudo mv $HOME/.config/hypr/hypridle_ddcutil.sh /usr/local/bin

echo "Script generated at: $OUT_0 (BUS=$BUS)"

sed -i "/XF86AudioMicMute/a\
bindel = ,XF86MonBrightnessUp, exec, ddcutil --bus=${BUS} setvcp 0x10 + 5; pkill -RTMIN+18 waybar\n\
bindel = ,XF86MonBrightnessDown, exec, ddcutil --bus=${BUS} setvcp 0x10 - 5; pkill -RTMIN+18 waybar" \
~/.config/hypr/keybinds.conf

