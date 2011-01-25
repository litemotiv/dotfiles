#!/bin/sh

export MPD_HOST=yuki
#syndaemon -i 1 &
/usr/bin/xset r rate 200 30
/usr/bin/xset +fp /usr/share/fonts/local
/usr/bin/xset fp rehash
/usr/bin/urxvtd -q -o -f

#exec dbus-launch ck-launch-session /usr/bin/i3 --force-xinerama
sh /home/ollie/.config/feh/fehbg

if [ -z $(pidof conky) ]; then
	conky | while read -r; do xsetroot -name "$REPLY"; done
fi

exec dbus-launch ck-launch-session /usr/bin/dwm
#exec /usr/bin/i3 --force-xinerama -V -d all >/home/ollie/.config/i3/i3log-$(date +'%F-%k-%M-%S') 2>&1

