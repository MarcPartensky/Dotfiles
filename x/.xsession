#!/bin/sh

/usr/bin/xset b off
/usr/bin/xsetroot -solid darkslategrey
# If feh was installed, this can be uncommented.
#/usr/bin/feh --bg-center 'IMAGE PATH HERE'
# If xautolocal was installed, this can be uncommented.
#/usr/bin/xautolock -locker /usr/local/bin/slock -detectsleep -secure -time 10 &
#/usr/local/bin/slstatus &
setxkbmap -option caps:escape
picom -b
WALLPAPERS_PATH=/home/marc/wallpapers /home/marc/.local/bin/wpp -n
/usr/local/bin/dwm
