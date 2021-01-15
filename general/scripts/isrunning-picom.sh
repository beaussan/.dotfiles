#!/bin/sh

case "$1" in
    --toggle)
        if [ "$(pgrep -x picom)" ]; then
            pkill picom
        else
            picom -b --config ~/.compton.conf
        fi
        ;;
    *)
        if [ "$(pgrep -x picom)" ]; then
            echo "履"
        else
            echo ""
        fi
        ;;
esac