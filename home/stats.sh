#!/bin/sh
if [ -z $(pidof conky) ]; then
	/usr/bin/conky | while read -r; do /usr/bin/xsetroot -name "$REPLY"; done &
fi
