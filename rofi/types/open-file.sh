#!/usr/bin/env bash

file="$1"
mime=$(file --mime-type -b "$file")

case "$mime" in
    image/*)
        gimp "$file" &
        ;;
    text/*|application/json|application/xml|inode/x-empty)
        kitty nvim "$file" &
        ;;
    application/pdf)
        xdg-open "$file" &
        ;;
    video/*|audio/*)
        xdg-open "$file" &
        ;;
    *)
        xdg-open "$file" &
        ;;
esac
