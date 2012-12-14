#!/bin/sh
if [ -z $(pidof conky) ]; then
	/usr/bin/conky 2> /dev/null | while read -r; do /usr/bin/xsetroot -name "$REPLY"; done &
fi
