#!/usr/bin/env bash

GLYPH="󰍬"

declare -a sources
declare -a labels
i=0

while read -r index name _; do
  desc=$(pactl list sources | awk -v n="$name" '
    $0 ~ "Name: "n {found=1}
    found && /Description:/ {
      sub("^[^:]*: ", "", $0)
      print
      exit
    }
  ')

  desc=${desc:-$name}

  sources[$i]="$name"
  labels[$i]="$GLYPH $desc"
  ((i++))
done < <(pactl list short sources | grep -v monitor)

selected_label=$(printf "%s\n" "${labels[@]}" \
  | rofi -dmenu -p "Select audio input device:")

# Resolve selected source from label
for idx in "${!labels[@]}"; do
  if [[ "${labels[$idx]}" == "$selected_label" ]]; then
    selected_source="${sources[$idx]}"
    break
  fi
done

if [[ -n "$selected_source" ]]; then
  pactl set-default-source "$selected_source"
  notify-send "Input device set to" "$selected_label"
else
  notify-send "Input device selection cancelled!"
fi
