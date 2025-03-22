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

eval set -- ${args}
  case $1 in
    -v | --volume) 		
		volume=$2; 
		wpctl set-volume @DEFAULT_AUDIO_SINK@ $volume
		current=`wpctl get-volume @DEFAULT_AUDIO_SINK@`
		arr=( ${current//[!0-9]/ } )
		dunstify -t 3000 -h string:x-dunst-stack-tag:progress "Volume: ${arr[1]}%" -h int:value:"${arr[1]}"
		shift 2 
		;;
    -b | --brightness)  
		brightness=$2; 
		brightnessctl s $brightness
		current=`brightnessctl g`
		perc=$(( 100*$current/255 ))
		dunstify -t 3000 -h string:x-dunst-stack-tag:display "Brightness: $perc%" -h int:value:"$perc"
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
