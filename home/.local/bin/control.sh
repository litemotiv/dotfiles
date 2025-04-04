#!/usr/bin/env bash
#
# Adapted from https://www.shellscript.sh/examples/getopt/
#
set -euo pipefail

volume=unset
brightness=unset

usage(){
>&2 cat << EOF
Usage: $0
    [ -v | --volume ] 5%+
    [ -b | --brightness ] 5%-
EOF
exit 1
}

args=$(getopt -a -o v:b:h --long volume:,brightness:,help -- "$@")

if [[ $# -eq 0 ]]; then
  usage
fi

# helper function to create a progress bar string
# 
# $1 percentage
# $2 label
function notification() {
	bar=""

	# 25 steps - divide percentage by 4
	level=$(($1/4))

	for i in $(seq 1 25);
	do
		if [ $i -lt $level ]
		then
		   bar+="■"	
		else
		   bar+=""	
		fi
	done
		
	notify-send -u low -i audio-volume-medium-symbolic -t 3000 -r 1 -e "$2" "$bar  <b>$1%</b>"
}

# commands
eval set -- ${args}
  case $1 in
    -v | --volume) 		
		volume=$2; 
		wpctl set-volume @DEFAULT_AUDIO_SINK@ $volume -l 1.0

		# get current level for OSD
		current=`wpctl get-volume @DEFAULT_AUDIO_SINK@`
		percent=`bc <<< "scale=0; (${current:8:5} * 100)/1"`
		notification "$percent" "Volume"
		
		shift 2 
		;;
    -b | --brightness)  
		brightness=$2; 
		brightnessctl s $brightness
		
		# get current level for OSD
		current=`brightnessctl g`
		percent=$(( 100*$current/255 ))
		notification "$percent" "Backlight"
		
		shift 2 
		;;
    -h | --help)    	
		usage; 
		shift   
		;;
    --) 
		shift; 
		break 
		;;
    *) 
		>&2 echo Unsupported option: $1
       usage 
	   ;;
  esac

#notify-send -e "$?"

#>&2 echo "volume  		: ${volume}"
#>&2 echo "brightness    : ${brightness}"
#>&2 echo "Parameters remaining are: $@"

exit 0
