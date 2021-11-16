#!/bin/sh

IS_PAUSE=$(dunstctl is-paused)
WAITING_AMOUNT=$(dunstctl count waiting)


case "$1" in
  --toggle)
    dunstctl set-paused toggle
    exit 0
    ;;
  *)

    if [[ "$IS_PAUSE" == "true" ]]; then
      echo " $WAITING_AMOUNT"
    else
      echo ""
    fi
    exit 0
    ;;
esac