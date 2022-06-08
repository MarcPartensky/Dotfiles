#!/bin/sh

/usr/bin/xset b off
/usr/bin/xsetroot -solid darkslategrey
# If xautolocal was installed, this can be uncommented.
/usr/bin/xautolock -locker /usr/local/bin/slock -detectsleep -secure -time 10 &
setxkbmap -option caps:escape
setxkbmap fr -variant us
picom -b --experimental-backends
find ~/wallpapers -name '*.jpg' | shuf -n 1 | tee /tmp/wpp | xargs -I % feh --bg-fill %
alacritty &
firefox &
spotify &
~/.local/bin/startdwm.sh
# instantwm
