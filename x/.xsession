#!/bin/sh

/usr/bin/xset b off
/usr/bin/xsetroot -solid darkslategrey
# If xautolocal was installed, this can be uncommented.
/usr/bin/xautolock -locker /usr/local/bin/slock -detectsleep -secure -time 10 &
$HOME/.local/bin/poststartx
