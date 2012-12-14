#!/bin/sh
export MPD_HOST=yuki
/usr/bin/urxvtd -q -o -f
/usr/bin/xcalib $HOME/Documents/MacbookAir.icc
/usr/bin/imlibsetroot --composite -p c $HOME/pictures/arch-wallpaper-1920.png
/usr/bin/xbacklight -set 15
$HOME/.dotfiles/home/stats.sh &
/usr/bin/urxvtc
/usr/bin/xset r rate 200 30
/usr/bin/xmodmap $HOME/.Xmodmap
/usr/bin/dwm 
#exec /usr/bin/compiz ccp
