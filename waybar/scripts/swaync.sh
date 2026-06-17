#!/bin/bash

output_status() {
    local count dnd
    count=$(swaync-client -c 2>/dev/null)
    dnd=$(swaync-client -D 2>/dev/null)
    [[ "$count" =~ ^[0-9]+$ ]] || count=0

    if [ "$dnd" = "true" ]; then
        echo "{\"text\": \"󱏧\", \"class\": \"dnd\", \"tooltip\": \"Do Not Disturb\"}"
    elif [ "$count" -eq 0 ]; then
        echo '{"text": "󰂚", "class": "empty", "tooltip": "No notifications"}'
    else
        echo "{\"text\": \"󱅫 ${count}\", \"class\": \"has-notifications\", \"tooltip\": \"${count} notification(s)\"}"
    fi
}

# Initial output
output_status

# Subscribe to swaync changes and update on each event
swaync-client --subscribe-waybar 2>/dev/null | while IFS= read -r _; do
    output_status
done
