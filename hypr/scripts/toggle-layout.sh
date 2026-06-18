#!/bin/bash

CurLayout=$(hyprctl getoption general:layout | grep str: | sed -E "s/str: //")
Layout="scrolling"

if [[ "$CurLayout" = "scrolling" ]]; then
  Layout="dwindle"
fi

hyprctl -q eval "hl.config({ general = { layout = '$Layout' } })"
