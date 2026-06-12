#!/usr/bin/env bash

dir="$HOME/.config/rofi/types"
theme='styleSmallOutline'

## Launch file browser and open selected file with xdg-open
rofi \
    -show filebrowser \
    -theme ${dir}/${theme}.rasi \
    -theme-str 'configuration { filebrowser { command: "bash /home/oleksandr/.config/rofi/types/open-file.sh"; } }'
