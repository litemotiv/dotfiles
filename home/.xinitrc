#!/bin/bash

export MPD_HOST=synology
/usr/bin/xrdb -merge ~/.Xresources &
syndaemon -i 1 &
xset r rate 200 30
xset +fp /usr/share/fonts/local
xset fp rehash
urxvtd -q -o -f

exec /usr/bin/i3 --force-xinerama
#exec /usr/bin/i3 >/home/ollie/.i3/i3log-$(date +'%F-%k-%M-%S') 2>&1

