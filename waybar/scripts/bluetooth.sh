#!/bin/bash

STATE_FILE="/tmp/waybar-bluetooth-state"

POWERED=$(bluetoothctl show 2>/dev/null | grep "Powered:" | awk '{print $2}')

if [ "$POWERED" != "yes" ]; then
    rm -f "$STATE_FILE"
    echo '{"text": "󰂲", "class": "off", "tooltip": "Bluetooth is off"}'
    exit 0
fi

# Check for a connected device
CONNECTED_NAME=$(bluetoothctl info 2>/dev/null | grep "Name:" | sed 's/.*Name: //')

if [ -n "$CONNECTED_NAME" ]; then
    BT_SINK=$(pactl list sinks short 2>/dev/null | grep -i "bluez\|bluetooth" | awk '{print $2}' | head -1)
    PREV_SINK=$(cat "$STATE_FILE" 2>/dev/null)

    # BT sink just appeared — switch default to it
    if [ -n "$BT_SINK" ] && [ "$PREV_SINK" != "$BT_SINK" ]; then
        echo "$BT_SINK" > "$STATE_FILE"
        pactl set-default-sink "$BT_SINK"
    fi

    # BT sink disappeared (handed off to another device) — restore laptop speakers
    if [ -z "$BT_SINK" ] && [ -n "$PREV_SINK" ]; then
        rm -f "$STATE_FILE"
        DEFAULT_SINK=$(pactl list sinks short 2>/dev/null | grep -iv "bluez\|bluetooth\|easy.effects" | grep -i "Speaker" | awk '{print $2}' | head -1)
        [ -z "$DEFAULT_SINK" ] && DEFAULT_SINK=$(pactl list sinks short 2>/dev/null | grep -iv "bluez\|bluetooth\|easy.effects" | awk '{print $2}' | head -1)
        [ -n "$DEFAULT_SINK" ] && pactl set-default-sink "$DEFAULT_SINK"
    fi

    BATTERY=$(bluetoothctl info 2>/dev/null | grep "Battery Percentage" | grep -oP '\d+(?=%)')
    if [ -n "$BATTERY" ]; then
        echo "{\"text\": \"󰂯 ${CONNECTED_NAME} ${BATTERY}%\", \"class\": \"connected\", \"tooltip\": \"Connected: ${CONNECTED_NAME}\"}"
    else
        echo "{\"text\": \"󰂯 ${CONNECTED_NAME}\", \"class\": \"connected\", \"tooltip\": \"Connected: ${CONNECTED_NAME}\"}"
    fi
else
    # Device fully disconnected — restore laptop speakers
    PREV_SINK=$(cat "$STATE_FILE" 2>/dev/null)
    if [ -n "$PREV_SINK" ]; then
        rm -f "$STATE_FILE"
        DEFAULT_SINK=$(pactl list sinks short 2>/dev/null | grep -iv "bluez\|bluetooth\|easy.effects" | grep -i "Speaker" | awk '{print $2}' | head -1)
        [ -z "$DEFAULT_SINK" ] && DEFAULT_SINK=$(pactl list sinks short 2>/dev/null | grep -iv "bluez\|bluetooth\|easy.effects" | awk '{print $2}' | head -1)
        [ -n "$DEFAULT_SINK" ] && pactl set-default-sink "$DEFAULT_SINK"
    fi
    echo '{"text": "󰂯", "class": "on", "tooltip": "Bluetooth is on"}'
fi
