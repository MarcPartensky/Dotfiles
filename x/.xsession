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
find $WALLPAPERS_PATH -name '*.jpg' | shuf -n 1 | tee /tmp/wpp | tee /dev/tty | xargs -I % feh --bg-fill %
/usr/local/bin/dwm
