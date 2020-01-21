#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

WIFI_CARD=$(iw dev | awk '$1=="Interface"{print $2}')
# Launch bar1 and bar2
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m WIFI_CARD=$WIFI_CARD polybar downbar &
    MONITOR=$m WIFI_CARD=$WIFI_CARD polybar default &
  done
else
  polybar downbar &
  polybar default &
fi

echo "Bars launched..."
