#!/bin/sh

CONTAINER_NAME=$(docker ps --format "{{.Names}}" | grep fakecam)
CURRENT_FILTER=$(cat ~/fakecamconf/config | head -n 1)

case "$1" in
    --toggle)
        res=$(echo "blur|starWars|image|green|none|off" | rofi -sep "|" -dmenu -i -p 'Blur: ' "" -hide-scrollbar -width 20 -sidebar-mode)

        if [[ "$res" == "off" ]]; then
            docker stop fakecam
        else
            echo $res > ~/fakecamconf/config
            docker start fakecam
        fi
        exit 0

        ;;
    *)
        if [ $CONTAINER_NAME ]; then
            echo "  $CURRENT_FILTER"
        else
            echo " 﫞 "
        fi
        ;;
esac