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
function create_progress() {
	for i in $(seq 1 20);
	do
		if [ $i -lt $level ]
		then
		   bar+="￭"	
		else
		   bar+="･"	
		fi
	done
}

# commands
eval set -- ${args}
  case $1 in
    -v | --volume) 		
		volume=$2; 
		wpctl set-volume @DEFAULT_AUDIO_SINK@ $volume -l 1.0
		current=`wpctl get-volume @DEFAULT_AUDIO_SINK@`
		new=`bc <<< "scale=0; (${current:8:5} * 100)/1"`

		# create progress bar and notify
		bar=""
		level=$((new/5))
		create_progress
		
		notify-send -i audio-volume-medium-symbolic -t 3000 -a vol -r 1 -e "Volume" "［ $bar ］$new%"
		shift 2 
		;;
    -b | --brightness)  
		brightness=$2; 
		brightnessctl s $brightness
		current=`brightnessctl g`
		perc=$(( 100*$current/255 ))

		# create progress bar and notify
		bar=""
		level=$((perc/5))
		create_progress
		
		notify-send -i video-display-symbolic -t 3000 -a bl -r 1 -e "Backlight" "［ $bar ］$perc%"
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
