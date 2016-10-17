#!/bin/sh
vol=$(amixer -D pulse sget Master | tail -n +7 | cut -f1 -d"]" | sed 's|.*\[\(.*\)|\1|');
var="$(echo -e "100%\n90%\n80%\n70%\n60%\n50%\n40%\n30%\n20%\n10%\n0%\nmute\unmute" | rofi -dmenu -hide-scrollbar -width -13  -xoffset -550 -mesg "Cur vol: $vol" -p "Set: ")" &&
if [ "$var" = "mute\unmute" ]; then
	amixer -D pulse sset Master 1+ toggle;
else
	amixer -D pulse sset Master $var;
fi
