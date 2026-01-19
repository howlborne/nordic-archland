#!/usr/bin/env bash
set -euo pipefail

OUT_0="$HOME/.config/waybar/scripts/brightness.sh"
OUT_1="$HOME/.config/hypr/hypridle.conf"

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

cat > "$OUT_1" <<EOF
general {
    lock_cmd = pidof hyprlock || hyprlock       # avoid starting multiple hyprlock instances.
    before_sleep_cmd = loginctl lock-session    # lock before suspend.
    after_sleep_cmd = hyprctl dispatch dpms on  # to avoid having to press a key twice to turn on the display.
}

listener {
    timeout = 120
    on-timeout = ddcutil --bus=$BUS setvcp 0x10 - 10; pkill -RTMIN+18 waybar         # set monitor backlight to (current - 10).
    on-resume = ddcutil --bus=$BUS setvcp 0x10 100; pkill -RTMIN+18 waybar         # restore monitor backlight..
}

listener {
    timeout = 180
    on-timeout = ddcutil --bus=$BUS setvcp 0x10 - 10; pkill -RTMIN+18 waybar
    on-resume = ddcutil --bus=$BUS setvcp 0x10 100; pkill -RTMIN+18 waybar
}

listener {
    timeout = 240
    on-timeout = ddcutil --bus=$BUS setvcp 0x10 - 10; pkill -RTMIN+18 waybar
    on-resume = ddcutil --bus=$BUS setvcp 0x10 100; pkill -RTMIN+18 waybar
}

listener {
    timeout = 300
    on-timeout = ddcutil --bus=$BUS setvcp 0x10 - 10; pkill -RTMIN+18 waybar
    on-resume = ddcutil --bus=$BUS setvcp 0x10 100; pkill -RTMIN+18 waybar
}

listener {
    timeout = 360
    on-timeout = ddcutil --bus=$BUS setvcp 0x10 - 10; pkill -RTMIN+18 waybar
    on-resume = ddcutil --bus=$BUS setvcp 0x10 100; pkill -RTMIN+18 waybar
}

listener {
    timeout = 420
    on-timeout = ddcutil --bus=$BUS setvcp 0x10 - 10; pkill -RTMIN+18 waybar
    on-resume = ddcutil --bus=$BUS setvcp 0x10 100; pkill -RTMIN+18 waybar
}

listener {
    timeout = 480
    on-timeout = ddcutil --bus=$BUS setvcp 0x10 - 10; pkill -RTMIN+18 waybar
    on-resume = ddcutil --bus=$BUS setvcp 0x10 100; pkill -RTMIN+18 waybar
}

listener {
    timeout = 540
    on-timeout = ddcutil --bus=$BUS setvcp 0x10 - 10; pkill -RTMIN+18 waybar
    on-resume = ddcutil --bus=$BUS setvcp 0x10 100; pkill -RTMIN+18 waybar
}

listener {
    timeout = 600
    on-timeout = ddcutil --bus=$BUS setvcp 0x10 - 10; pkill -RTMIN+18 waybar
    on-resume = ddcutil --bus=$BUS setvcp 0x10 100; pkill -RTMIN+18 waybar
}

listener {
    timeout = 660
    on-timeout = ddcutil --bus=$BUS setvcp 0x10 - 10; pkill -RTMIN+18 waybar
    on-resume = ddcutil --bus=$BUS setvcp 0x10 100; pkill -RTMIN+18 waybar
}

# turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
# listener {
#     timeout = 150                                          # 2.5min.
#     on-timeout = brightnessctl -sd rgb:kbd_backlight set 0 # turn off keyboard backlight.
#     on-resume = brightnessctl -rd rgb:kbd_backlight        # turn on keyboard backlight.
# }

# listener {
#     timeout = 300                                 # 5 min timeout
#     on-timeout = loginctl lock-session            # lock screen when timeout has passed
# }
EOF

echo "Script generated at: $OUT_0 (BUS=$BUS)"

sed -i "/XF86AudioMicMute/a\
bindel = ,XF86MonBrightnessUp, exec, ddcutil --bus=${BUS} setvcp 0x10 + 5; pkill -RTMIN+18 waybar\n\
bindel = ,XF86MonBrightnessDown, exec, ddcutil --bus=${BUS} setvcp 0x10 - 5; pkill -RTMIN+18 waybar" \
~/.config/hypr/keybinds.conf

