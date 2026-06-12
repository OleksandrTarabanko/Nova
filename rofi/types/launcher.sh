dir="$HOME/.config/rofi/types"
theme='styleSmallOutline'

## Run
pkill rofi || rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
