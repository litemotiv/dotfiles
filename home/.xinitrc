#!/bin/sh
export MPD_HOST=yuki
/usr/bin/xset r rate 200 30
/usr/bin/urxvtd -q -o -f
/usr/bin/xcalib /home/ollie/Documents/MacbookAir.icc
/usr/bin/imlibsetroot --composite -p c /home/ollie/pictures/arch-wallpaper-1920.png
/usr/bin/xmodmap /home/ollie/.Xmodmap
/usr/bin/xbacklight -set 15
$HOME/.dotfiles/home/stats.sh &
/usr/bin/urxvtc
#exec ck-launch-session /usr/bin/dwm
/usr/bin/dwm
#exec /usr/bin/compiz ccp
