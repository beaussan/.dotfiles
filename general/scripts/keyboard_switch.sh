#!/bin/sh

CURRENT_LANG=$(setxkbmap -print -verbose 10 | grep layout | rev | cut -d ' ' -f 1 | rev)

case "$1" in
    --toggle)
        if [[ "$CURRENT_LANG" == "fr" ]]; then
            setxkbmap us
        else
            setxkbmap fr
        fi
        espanso restart
        exit 0

        ;;
    *)
        echo " $CURRENT_LANG"
        exit 0
        ;;
esac