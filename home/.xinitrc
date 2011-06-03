#!/bin/sh
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
	eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

export MPD_HOST=yuki
/usr/bin/xset r rate 200 30
/usr/bin/urxvtd -q -o -f
/usr/local/bin/backlight 8

/usr/bin/imlibsetroot /home/ollie/pictures/arch-wallpaper-dual.png

if [ -z $(pidof conky) ]; then
	/usr/bin/conky | while read -r; do /usr/bin/xsetroot -name "$REPLY"; done &
fi

/usr/bin/urxvtc
/usr/bin/ck-launch-session /usr/bin/dwm
