#!/bin/bash

name=`iwconfig 2>/dev/null | grep 'ESSID:' | cut -d ':' -f 2 | tr "\"" " "`
#vpn=$(ifconfig tap0 2&>1  > /dev/null && echo "  ")
vpn=$(ip link ls tap0 2>/dev/null 1>/dev/null && echo "  " || echo " ")
if $(ip link ls tap0 2>/dev/null 1>/dev/null); then
	vpn=" "
else
	vpn=""
fi
if [[ "$name" == "off/any  " ]]
then
	echo "" $vpn "OFF  "
else
	echo "" $vpn $name ""
fi
