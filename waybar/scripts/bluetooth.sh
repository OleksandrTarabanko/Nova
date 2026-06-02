#!/bin/bash

POWERED=$(bluetoothctl show 2>/dev/null | grep "Powered:" | awk '{print $2}')

if [ "$POWERED" != "yes" ]; then
    echo '{"text": "󰂲 OFF", "class": "off", "tooltip": "Bluetooth is off"}'
    exit 0
fi

# Check for a connected device
CONNECTED_NAME=$(bluetoothctl info 2>/dev/null | grep "Name:" | sed 's/.*Name: //')

if [ -n "$CONNECTED_NAME" ]; then
    BATTERY=$(bluetoothctl info 2>/dev/null | grep "Battery Percentage" | grep -oP '\d+(?=%)')
    if [ -n "$BATTERY" ]; then
        echo "{\"text\": \"󰂯 ${CONNECTED_NAME} ${BATTERY}%\", \"class\": \"connected\", \"tooltip\": \"Connected: ${CONNECTED_NAME}\"}"
    else
        echo "{\"text\": \"󰂯 ${CONNECTED_NAME}\", \"class\": \"connected\", \"tooltip\": \"Connected: ${CONNECTED_NAME}\"}"
    fi
else
    echo '{"text": "󰂯 ON", "class": "on", "tooltip": "Bluetooth is on"}'
fi
