#!/bin/zsh
# Default acpi script that takes an entry for all actions

# NOTE: This is a 2.6-centric script.  If you use 2.4.x, you'll have to
#       modify it to not use /sys

set $*

case "$1" in
    button/power)
        case "$2" in
            PWRF)   				
				CHOICE=$(DISPLAY="0:0" Xdialog --menubox "Are you sure?" 200x120 2 "Suspend" "" "Shutdown" "" 2>&1 >/dev/null);

				if [[ $CHOICE == "Suspend" ]]; then
					echo "mem" > /sys/power/state;
				elif [[ $CHOICE == "Shutdown" ]]; then
					systemctl poweroff;
				fi
				;;
        esac
        ;;
    button/lid)
		PREVIOUSVAL=$(cat /tmp/backlight); 

		BRIGHTFILE='/sys/class/backlight/apple_backlight/brightness';
		ACTUALVAL=$(cat $BRIGHTFILE);

		# Disable
		if [[ $ACTUALVAL -gt 0 ]]; then
			NEWVAL=0;
			echo $ACTUALVAL > /tmp/backlight;
		# Enable
		else
			NEWVAL=$PREVIOUSVAL;
		fi
		
		echo $NEWVAL > $BRIGHTFILE;
		;;
    *)
        logger "ACPI group/action undefined: $1 / $2"
        ;;
esac
