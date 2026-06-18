#!/bin/sh

ROFI_THEME="$HOME/.config/rofi/types/styleSmallOutline.rasi"

sinks_data=$(pactl list sinks | awk '
    /^\tName:/        { name = $2 }
    /^\tDescription:/ { desc = $0; sub(/^\tDescription: /, "", desc); print name "\t" desc }
')

current=$(pactl get-default-sink)

menu=$(printf '%s\n' "$sinks_data" | awk -F'\t' -v cur="$current" '{
    mark = ($1 == cur) ? "● " : "○ "
    print mark $2
}')

chosen=$(printf '%s\n' "$menu" | rofi -dmenu -i -p "Output" -theme "$ROFI_THEME")
[ -z "$chosen" ] && exit 0

clean_desc=$(printf '%s' "$chosen" | sed 's/^[●○] //')
chosen_name=$(printf '%s\n' "$sinks_data" | awk -F'\t' -v d="$clean_desc" \
    '$2 == d { print $1; exit }')

[ -z "$chosen_name" ] && exit 1

old_sink=$(pactl get-default-sink)
pactl set-default-sink "$chosen_name"

# Move all active streams to the new sink
pactl list short sink-inputs | awk '{print $1}' | while read -r input; do
    pactl move-sink-input "$input" "$chosen_name"
done

# Reload waybar so cava reconnects to the new default source monitor
pkill -SIGUSR2 waybar