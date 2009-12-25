#!/bin/bash

export MPD_HOST=synology
/usr/bin/xrdb -merge ~/.Xresources &
xset r rate 200 30 &
urxvtd -q -o -f

#SSH passwords
#eval `/usr/bin/ssh-agent`
#SSH_ASKPASS=/usr/lib/openssh/x11-ssh-askpass ssh-add < /dev/null

#exec /usr/bin/ion3
#ulimit -c unlimited

sh /home/ollie/.fehbg &
sh /usr/local/bin/stats.sh &
exec /usr/bin/i3
#exec /usr/bin/i3 >/home/ollie/.i3/i3log-$(date +'%F-%k-%M-%S') 2>&1

#exec /usr/bin/subtle &
#PID=$!
#sleep 1 && sh /home/ollie/.fehbg 
#wait $PID
