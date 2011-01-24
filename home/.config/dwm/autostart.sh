#!/bin/sh

sh /home/ollie/.config/feh/fehbg

if [ -z $(pidof conky) ]; then
	conky | while read -r; do xsetroot -name "$REPLY"; done
fi
