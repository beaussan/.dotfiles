#!/bin/bash

name=`iwconfig 2>/dev/null | grep 'ESSID:' | cut -d ':' -f 2 | tr "\"" " "`
if [ "$name" == "off/any" ]
then
	echo " OFF"
else
	echo "" $name ""
fi
