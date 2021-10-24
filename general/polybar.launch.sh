#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

hs=`hostname`
NETWORK_TABS='wlan-full'

if [ $hs = "gaya" ]; then
   NETWORK_TABS='wlan-soft eth-full'
   NETWORK_TABS='wlan-full eth-full'
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
          DP-3)
            MODULE_BOTTOM_RIGHT="cpu memory temperature"
            MODULE_TOP_RIGHT="volume date Shutdown"
          ;;
          DP-0)
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

    LOGFILE="$HOME/.config/polybar/$m.log"
    LOGFILE_BOTTOM="$HOME/.config/polybar/$m.downbar.log"
    LOGFILE_UP="$HOME/.config/polybar/$m.default.log"

    touch $LOGFILE_BOTTOM $LOGFILE_UP

    echo monitor : $m | tee $LOGFILE_BOTTOM $LOGFILE_UP > /dev/null
    echo tray : $tray | tee -a $LOGFILE_BOTTOM $LOGFILE_UP > /dev/null
    echo wifiCard: $WIFI_CARD | tee -a $LOGFILE_BOTTOM $LOGFILE_UP > /dev/null
    echo networkTabs: "$NETWORK_TABS" | tee -a $LOGFILE_BOTTOM $LOGFILE_UP > /dev/null
    echo MODULE_BOTTOM_RIGHT: "$MODULE_BOTTOM_RIGHT" | tee -a $LOGFILE_BOTTOM $LOGFILE_UP > /dev/null
    echo MODULE_TOP_RIGHT: "$MODULE_TOP_RIGHT" | tee -a $LOGFILE_BOTTOM $LOGFILE_UP > /dev/null

    MODULE_BOTTOM_RIGHT="$MODULE_BOTTOM_RIGHT" \
    MODULE_TOP_RIGHT="$MODULE_TOP_RIGHT" \
    MONITOR=$m \
    WIFI_CARD=$WIFI_CARD \
    TRAY_POSITION=$tray \
    polybar downbar 2>&1 | tee -a $LOGFILE_BOTTOM > /dev/null & disown

    MODULE_BOTTOM_RIGHT="$MODULE_BOTTOM_RIGHT" \
    MODULE_TOP_RIGHT="$MODULE_TOP_RIGHT" \
    MONITOR=$m \
    WIFI_CARD=$WIFI_CARD \
    TRAY_POSITION=$tray \
    polybar default 2>&1 | tee -a $LOGFILE_UP > /dev/null & disown
  
  done
else
  polybar downbar &
  polybar default &
fi

echo "Bars launched..."
