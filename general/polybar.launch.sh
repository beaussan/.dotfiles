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

MODULE_RIGHT="$NETWORK_TABS xbacklight battery cpu memory temperature"


WIFI_CARD=$(iw dev | awk '$1=="Interface"{print $2}')
# Launch bar1 and bar2
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do

    if [ $hs = "gaya" ]; then
      [[ $m = "DP-3" ]] && tray="right" || tray=""
      
      else
      [[ $m = eDP1 ]] && tray="right" || tray=""
    fi

    echo $m $tray $WIFI_CARD $NETWORK_TABS
    MODULE_RIGHT="$MODULE_RIGHT" MONITOR=$m WIFI_CARD=$WIFI_CARD TRAY_POSITION=$tray polybar downbar &
    MONITOR=$m WIFI_CARD=$WIFI_CARD polybar default &
  done
else
  polybar downbar &
  polybar default &
fi

echo "Bars launched..."
