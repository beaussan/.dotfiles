conky -c ~/.conkyrc > ~/scripts/tmpSys &&
mapfile -t sysinfos <~/scripts/tmpSys &&
var="$(echo -e "Hostname: $HOSTNAME\n"${sysinfos[0]}"\n"${sysinfos[4]}"\n"${sysinfos[1]}"\n"${sysinfos[2]}"\n"${sysinfos[3]}"\n"${sysinfos[5]}"\n"${sysinfos[6]}"\n"${sysinfos[7]}"\n"${sysinfos[8]}"\nreset yabar" | rofi -dmenu -hide-scrollbar -width -30 -p "System Status: ")"
rm ~/scripts/tmpSys
if [ "$var" = "reset yabar" ] 
then
	pkill yabar
	yabar & disown
fi
