#!/bin/sh
export MPD_HOST=yuki
/usr/bin/xset r rate 200 30
/usr/bin/urxvtd -q -o -f
/usr/local/bin/backlight 8

/usr/bin/imlibsetroot --composite  /home/ollie/pictures/arch-wallpaper-dual.png
$HOME/.dotfiles/home/stats.sh &

/usr/bin/urxvtc
exec ck-launch-session dbus-launch /usr/bin/dwm
