#!/bin/sh
gcalcli agenda > tmp.out || exit 1

cat -v tmp.out | sed -e 's/\^\[\[0m^\[\[0m//g' -e 's/\^\[\[0m\^\[\[0;33m//g' -e 's/\$//g' -e 's/\^\[\[0m\^\[\[0;36m//g' -e 's/M-CM-)/é/g' -e 's/\^\[\[0m//g' -e 's/\^\[\[0\;33m//g' -e 's/\^\[\[31\;1m/***/g' -e "s/[[:space:]]\+/ /g" > out.prossessed
cat out.prossessed | grep -E "\*\*\*.*" -A 1 | sed -e 's/\*\*\*//g' -e "s/[[:space:]]\+/ /g" | cut -d " " -f 2- | sed -e 's/Length: //g' -e 's/[0-9]*:[0-9]* /&\n/g' > finalSimple
