#!/bin/sh
data=$(acpitool | grep Battery | cut -d ':' -f 2- | sed -e 's/,//g' | cut -d ' ' -f 2-)
status=$(echo $data | cut -d ' ' -f 1)
purs=$(echo $data | cut -d ' ' -f 2 | sed -e 's/\..*%/%/g' )
rema=$(echo $data | cut -d ' ' -f 3 | cut -d ':' -f 1-2 | sed -e 's/:/h/g' -e 's/.*/(&m)/g' )
if [[ "$status" == "Discharging" ]]; then
  icon="    "
  echo "" $icon $purs $rema " "
else
  icon="    "
  echo "" $icon $purs " "
fi
