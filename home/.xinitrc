#!/bin/bash

export MPD_HOST=synology
/usr/bin/xrdb -merge ~/.Xresources &
xset r rate 200 30 &
xset +fp /usr/share/fonts/local
xset fp rehash
urxvtd -q -o -f

sh /home/ollie/.fehbg &
(sleep 3; sh /usr/local/bin/stats.sh) &
exec /usr/bin/i3
#exec /usr/bin/i3 >/home/ollie/.i3/i3log-$(date +'%F-%k-%M-%S') 2>&1

