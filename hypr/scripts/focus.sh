#!/bin/bash
# Focus in a direction, preferring windows on the same monitor.
# Only crosses to another monitor when no window exists in that direction on the current monitor.
# Usage: focus.sh <l|r|u|d>

dir=$1

# Map short direction letters to full names for hl.dsp.focus
case "$dir" in
    l) full_dir="l" ;;
    r) full_dir="r" ;;
    u) full_dir="u" ;;
    d) full_dir="d" ;;
    *) exit 1 ;;
esac

current=$(hyprctl activewindow -j)
current_addr=$(echo "$current" | jq -r '.address')
current_mon=$(echo "$current" | jq '.monitor')
cur_cx=$(echo "$current" | jq '(.at[0] + .size[0] / 2)')
cur_cy=$(echo "$current" | jq '(.at[1] + .size[1] / 2)')

# Find the closest window on the same monitor in the given direction
case "$dir" in
    l)
        best=$(hyprctl clients -j | jq -r \
            --argjson mon "$current_mon" \
            --arg addr "$current_addr" \
            --argjson cx "$cur_cx" \
            --argjson cy "$cur_cy" \
            '[.[] | select(.monitor == $mon and .address != $addr and .mapped == true)
                  | select((.at[0] + .size[0] / 2) < $cx)]
             | sort_by( ((.at[0] + .size[0]/2) - $cx) * ((.at[0] + .size[0]/2) - $cx)
                      + ((.at[1] + .size[1]/2) - $cy) * ((.at[1] + .size[1]/2) - $cy) )
             | first | .address // empty')
        ;;
    r)
        best=$(hyprctl clients -j | jq -r \
            --argjson mon "$current_mon" \
            --arg addr "$current_addr" \
            --argjson cx "$cur_cx" \
            --argjson cy "$cur_cy" \
            '[.[] | select(.monitor == $mon and .address != $addr and .mapped == true)
                  | select((.at[0] + .size[0] / 2) > $cx)]
             | sort_by( ((.at[0] + .size[0]/2) - $cx) * ((.at[0] + .size[0]/2) - $cx)
                      + ((.at[1] + .size[1]/2) - $cy) * ((.at[1] + .size[1]/2) - $cy) )
             | first | .address // empty')
        ;;
    u)
        best=$(hyprctl clients -j | jq -r \
            --argjson mon "$current_mon" \
            --arg addr "$current_addr" \
            --argjson cx "$cur_cx" \
            --argjson cy "$cur_cy" \
            '[.[] | select(.monitor == $mon and .address != $addr and .mapped == true)
                  | select((.at[1] + .size[1] / 2) < $cy)]
             | sort_by( ((.at[0] + .size[0]/2) - $cx) * ((.at[0] + .size[0]/2) - $cx)
                      + ((.at[1] + .size[1]/2) - $cy) * ((.at[1] + .size[1]/2) - $cy) )
             | first | .address // empty')
        ;;
    d)
        best=$(hyprctl clients -j | jq -r \
            --argjson mon "$current_mon" \
            --arg addr "$current_addr" \
            --argjson cx "$cur_cx" \
            --argjson cy "$cur_cy" \
            '[.[] | select(.monitor == $mon and .address != $addr and .mapped == true)
                  | select((.at[1] + .size[1] / 2) > $cy)]
             | sort_by( ((.at[0] + .size[0]/2) - $cx) * ((.at[0] + .size[0]/2) - $cx)
                      + ((.at[1] + .size[1]/2) - $cy) * ((.at[1] + .size[1]/2) - $cy) )
             | first | .address // empty')
        ;;
    *)
        exit 1
        ;;
esac

if [ -n "$best" ]; then
    hyprctl dispatch "hl.dsp.focus({ window = \"address:$best\" })"
else
    # Nothing on this monitor in that direction — cross to the adjacent monitor
    hyprctl dispatch "hl.dsp.focus({ direction = \"$full_dir\" })"
fi
