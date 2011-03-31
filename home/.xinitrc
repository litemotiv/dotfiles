#!/bin/sh

export MPD_HOST=yuki
/usr/bin/xset r rate 200 30
/usr/bin/urxvtd -q -o -f

#exec dbus-launch ck-launch-session /usr/bin/i3 --force-xinerama
sh /home/ollie/.fehbg

if [ -z $(pidof conky) ]; then
	conky | while read -r; do xsetroot -name "$REPLY"; done &
fi

exec /usr/bin/urxvtc &
exec dbus-launch ck-launch-session /usr/bin/dwm
#exec /usr/bin/i3 --force-xinerama -V -d all >/home/ollie/.config/i3/i3log-$(date +'%F-%k-%M-%S') 2>&1

