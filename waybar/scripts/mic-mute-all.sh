#!/bin/sh
# Toggle mute on all microphone sources simultaneously.
# Uses the default source's current state to decide the new state.
state=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')
if [ "$state" = "yes" ]; then
    new_state=0
else
    new_state=1
fi
pactl list short sources | grep -v monitor | awk '{print $2}' | while read -r src; do
    pactl set-source-mute "$src" "$new_state"
done
