#!/bin/sh

STATUS=$(pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null)

if echo "$STATUS" | grep -q "yes"; then
    echo '{"text": "󰍭", "class": "muted", "tooltip": "Microphone: Muted"}'
else
    echo '{"text": "󰍬", "class": "active", "tooltip": "Microphone: Active"}'
fi
