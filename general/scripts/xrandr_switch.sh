#!/bin/sh

CURRENT_MODE=$(autorandr | grep 'current' | cut -d ' ' -f 1)
ALL_MODS=$(autorandr | cut -d ' ' -f 1 | tr '\n' '|')



case "$1" in
    --toggle)
        res=$(echo "$ALL_MODS" | rofi -sep "|" -dmenu -i -p 'Screen mode: ' "" -hide-scrollbar -width 20 -sidebar-mode)

        if [ -z "$res" ]; then exit 0; fi
        pkill polybar
        autorandr $res && feh --bg-scale ~/.dotfiles/wall.jpg && ~/.config/polybar/launch.sh
        exit 0

        ;;
    *)
        if [ $CURRENT_MODE ]; then
            echo "  $CURRENT_MODE"
        else
            echo "  Autorandr not detected"
        fi
        ;;
esac