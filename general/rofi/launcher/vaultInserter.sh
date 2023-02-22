#!/usr/bin/env bash

source $HOME/.obsEnv


dir="$HOME/.config/rofi/launcher"
theme='style-single'



newValue=$(rofi -theme ${dir}/${theme}.rasi \
           -dmenu \
            -theme-str 'listview { enabled: false;}' -lines 0 -p 'What did you do : ')


if [[ -z "$newValue" ]]; then
    exit 0
fi 

echo $newValue


curl -X 'PATCH' \
  'http://127.0.0.1:27123/periodic/daily/' \
  -H 'accept: */*' \
  -H 'Heading: Work log' \
  -H 'Content-Insertion-Position: end' \
  -H 'Heading-Boundary: ::' \
  -H "Authorization: Bearer $OBSIDIAN_TOKEN" \
  -H 'Content-Type: text/markdown' \
  -d "* $newValue" > /dev/null