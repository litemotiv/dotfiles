#!/bin/zsh
# Default acpi script that takes an entry for all actions

# NOTE: This is a 2.6-centric script.  If you use 2.4.x, you'll have to
#       modify it to not use /sys

set $*

case "$1" in
	button/power)
		case "$2" in
			PWRF)   				
				#CHOICE=$(DISPLAY=":0.0" Xdialog --menubox "Are you sure?" 200x120 2 "Suspend" "" "Shutdown" "" 2>&1 >/dev/null);

				#if [[ $CHOICE == "Suspend" ]]; then
					echo "mem" > /sys/power/state;
				#elif [[ $CHOICE == "Shutdown" ]]; then
				#	systemctl poweroff;
				#fi
				#;;
		esac
        ;;
	button/volumeup)
		OUTPUT=$(/usr/bin/amixer set Master 5%+ | egrep 'Playback.*?\[o' | egrep -o '\[.+%\]');
		DISPLAY=":0.0" /usr/bin/xsetroot -name "Volume: $OUTPUT";
	;;
	button/volumedown)
		OUTPUT=$(/usr/bin/amixer set Master 5%- | egrep 'Playback.*?\[o' | egrep -o '\[.+%\]');
		DISPLAY=":0.0" /usr/bin/xsetroot -name "Volume: $OUTPUT";
	;;
	button/lid)
		BRIGHTNESS='/sys/class/backlight/intel_backlight/brightness';
		ACTUALVAL=$(cat $BRIGHTNESS);
		if [[ $ACTUALVAL -gt 0 ]]; then
			/usr/bin/synclient TouchpadOff=1;
			DISPLAY=":0.0" /usr/bin/xbacklight -set 0;
		else
			DISPLAY=":0.0" /usr/bin/xbacklight -set 15;
			/usr/bin/synclient TouchpadOff=0;
		fi
		
	;;
	*)
		logger "ACPI group/action undefined: $1 / $2"
        ;;
esac
