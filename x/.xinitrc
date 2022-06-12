#!/usr/bin/sh
# Copyright (C) 1999 - 2005 Red Hat, Inc. All rights reserved. This
# copyrighted material is made available to anyone wishing to use, modify,
# copy, or redistribute it subject to the terms and conditions of the
# GNU General Public License version 2.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# Authors:
#	Mike A. Harris <mharris@redhat.com>

# Mandatorily source xinitrc-common, which is common code shared between the
# Xsession and xinitrc scripts which has been factored out to avoid duplication
# . /etc/X11/xinit/xinitrc-common

# The user may have their own clients they want to run.  If they don't,
# fall back to system defaults.
if [ -f $HOME/.Xclients ]; then
    exec $CK_XINIT_SESSION $SSH_AGENT $HOME/.Xclients || \
    exec $CK_XINIT_SESSION $SSH_AGENT $HOME/.Xclients
elif [ -f /etc/X11/xinit/Xclients ]; then
    exec $CK_XINIT_SESSION $SSH_AGENT /etc/X11/xinit/Xclients || \
    exec $CK_XINIT_SESSION $SSH_AGENT /etc/X11/xinit/Xclients
else
    # Failsafe settings.  Although we should never get here
    # (we provide fallbacks in Xclients as well) it can't hurt.
    [ -x /usr/bin/xsetroot ] && /usr/bin/xsetroot -solid '#222E45'
    [ -x /usr/bin/xclock ] && /usr/bin/xclock -geometry 100x100-5+5 &
    [ -x /usr/bin/xterm ] && xterm -geometry 80x50-50+150 &
    [ -x /usr/bin/twm ] && /usr/bin/twm
fi


systemctl --user import-environment DISPLAY
setxkbmap -option caps:escape
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape'
setxkbmap fr -variant us
# xset r rate 200 50
# xset dpms 0 0 0
# xset s 0
xrdb -merge $HOME/.Xresources
xsetroot -cursor_name left_ptr

setxkbmap -option caps:escape
setxkbmap fr -variant us
picom -b --experimental-backends
find ~/wallpapers -name '*.jpg' | shuf -n 1 | tee /tmp/wpp | xargs -I % feh --bg-fill %
# instantwm
alacritty &
firefox &
spotify &
systemctl --user start dwmblocks
$HOME/.local/bin/startdwm.sh
