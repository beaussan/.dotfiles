# Power management

```sh
sudo powertop
s-tui
yaourt s-tui
sudo powertop
yaourt bumblebee
yaourt bbswitch
sudo systemctl enable bumblebeed.service
sudo  systemctl start bumblebeed.service

sudo powertop

sudo gpasswd -a beaussan bumblebee

xrandr --listproviders
glxspheres64
optirun glxsphere64

bumblebeed --help
optirun glxsphere64

systemctl status bumblebeed

yaourt yay
yay yay
cat /etc/pacman.conf
yay tlp
tlp
sudo systemctl enable tlp.service tlp-sleep.service 
sudo systemctl start tlp tlp-sleep.service
yay tlp
```

```sh

cat << EOF | sudo tee /etc/systemd/system/powertop.service
[Unit]
Description=PowerTOP auto tune

[Service]
Type=idle
Environment="TERM=dumb"
ExecStart=/usr/sbin/powertop --auto-tune

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable powertop.service
```