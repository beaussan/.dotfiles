#!/bin/bash

fakeroot powertop --html=/tmp/power.html > /dev/null 2>&1
echo $(cat /tmp/power.html | grep  discharge | cut -b 78- | cut -f1,3 -d" ")