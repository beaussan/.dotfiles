#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

hs=`hostname`
NETWORK_TABS='wlan-full'

if [ $hs = "gaya" ]; then
   NETWORK_TABS='wlan-soft eth-full'
fi

MODULE_BOTTOM_RIGHT="$NETWORK_TABS xbacklight battery cpu memory temperature"
MODULE_TOP_RIGHT="volume isrunning-picom pkg time-SF time-BENGA date Shutdown"


WIFI_CARD=$(iw dev | awk '$1=="Interface"{print $2}')
# Launch bar1 and bar2
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    
    case "$hs" in
      gaya)
        MODULE_BOTTOM_RIGHT="$NETWORK_TABS cpu memory temperature"
        tray=""
        case "$m" in
          DP-1)
            MODULE_BOTTOM_RIGHT="cpu memory temperature"
            MODULE_TOP_RIGHT="volume date Shutdown"
          ;;
          DP-2)
            tray="right"
            MODULE_TOP_RIGHT="volume isrunning-picom pkg time-SF time-BENGA date Shutdown"
          ;;
          DP-5)
            MODULE_TOP_RIGHT="volume isrunning-picom pkg date Shutdown"
          ;;
          *)
            MODULE_TOP_RIGHT="volume isrunning-picom pkg date Shutdown"
          ;;
        esac
      ;;

      *)
        [[ $m = eDP1 ]] && tray="right" || tray=""
      ;;
    esac

    echo monitor : $m
    echo tray : $tray
    echo wifiCard: $WIFI_CARD
    echo networkTabs: "$NETWORK_TABS"
    echo MODULE_BOTTOM_RIGHT: "$MODULE_BOTTOM_RIGHT"
    echo MODULE_TOP_RIGHT: "$MODULE_TOP_RIGHT"
    MODULE_BOTTOM_RIGHT="$MODULE_BOTTOM_RIGHT" MODULE_TOP_RIGHT="$MODULE_TOP_RIGHT" MONITOR=$m WIFI_CARD=$WIFI_CARD TRAY_POSITION=$tray polybar downbar &
    MODULE_BOTTOM_RIGHT="$MODULE_BOTTOM_RIGHT" MODULE_TOP_RIGHT="$MODULE_TOP_RIGHT" MONITOR=$m WIFI_CARD=$WIFI_CARD TRAY_POSITION=$tray polybar default &
  
  done
else
  polybar downbar &
  polybar default &
fi

echo "Bars launched..."
