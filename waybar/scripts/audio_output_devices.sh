#!/usr/bin/env bash

GLYPH="󰓃"

declare -a sinks
declare -a labels
i=0

while read -r index name _; do
  desc=$(pactl list sinks | awk -v n="$name" '
    $0 ~ "Name: "n {found=1}
    found && /Description:/ {
      sub("^[^:]*: ", "", $0)
      print
      exit
    }
  ')

  desc=${desc:-$name}

  sinks[$i]="$name"
  labels[$i]="$GLYPH $desc"
  ((i++))
done < <(pactl list short sinks | grep -v dummy)

selected_label=$(printf "%s\n" "${labels[@]}" \
  | rofi -dmenu -p "Select audio output device:")

# Resolve index from label
for idx in "${!labels[@]}"; do
  if [[ "${labels[$idx]}" == "$selected_label" ]]; then
    selected_sink="${sinks[$idx]}"
    break
  fi
done

if [[ -n "$selected_sink" ]]; then
  pactl set-default-sink "$selected_sink"

  # Move active streams
  pactl list short sink-inputs | awk '{print $1}' | while read -r input; do
    pactl move-sink-input "$input" "$selected_sink"
  done

  notify-send "Output device set to" "$selected_label"
else
  notify-send "Output device selection cancelled!"
fi
