#!/bin/bash

name=`iwconfig 2>/dev/null | grep 'ESSID:' | cut -d ':' -f 2 | tr "\"" " "`
#other=$(ifconfig tap0 2&>1  > /dev/null && echo "  ")
other=$(ip link ls tap0 2>/dev/null 1>/dev/null && echo "  " || echo " ")
if $(ip link ls tap0 2>/dev/null 1>/dev/null); then
	other=" "
else
	other=""
fi
if [ "$name" == "off/any" ]
then
	echo "" $other "OFF"
else
	echo "" $other $name ""
fi
