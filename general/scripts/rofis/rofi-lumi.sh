#!/bin/sh
lumi=$(xbacklight -get | cut -d "." -f 1);
var="$(echo -e "100%\n90%\n80%\n70%\n60%\n50%\n40%\n30%\n20%\n10%\n1%" | rofi -dmenu -hide-scrollbar -width -13  -xoffset -400 -mesg "Cur lum: $lumi"% -p "Set: ")" &&
xbacklight -set $var;
