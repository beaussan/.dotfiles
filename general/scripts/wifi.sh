#!/bin/bash

#name=`iwconfig  | grep ESSID | awk '{print $4}' | tr -d 'ESID:"'`

name="off"
if [ $name == "off/any" ]
then
	echo " OFF"
else
	echo "" $name
fi
