#!/bin/sh
export MPD_HOST=yuki
/usr/bin/xset r rate 200 30
/usr/bin/urxvtd -q -o -f
/usr/bin/xcalib /home/ollie/Documents/MacbookAir.icc
/usr/bin/imlibsetroot --composite  /home/ollie/pictures/arch-wallpaper-dual.png
/usr/bin/xmodmap /home/ollie/.Xmodmap
$HOME/.dotfiles/home/stats.sh &

/usr/bin/urxvtc
#exec ck-launch-session /usr/bin/dwm
/usr/bin/dwm
