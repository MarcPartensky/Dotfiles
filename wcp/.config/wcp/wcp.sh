#!/usr/bin/env bash

PIPE_IN="/tmp/wcp"

# reset fifo in case it already exists and used by an older process
rm -f $PIPE_IN
mkfifo $PIPE_IN
exec 3<>$PIPE_IN

# update sliders and labels in ui
function update()
{
    echo "WCP.SH Getting volume"
    # PULSEAUDIO - uncomment if you use pulseaudio
    # vol=$(pulsemixer --get-volume | awk '{print $1;}')
    # volrat=$(echo "scale=2 ; $vol / 100" | bc)
    echo "WCP.SH Volume Ratio $volrat"

    echo "WCP.SH Getting brightness"
    # BRIGHTNESSCONTROL - uncomment if you have an lcd & use brightnesscontrol
    # lcdact=$(brightnessctl g)
    # lcdmax=$(brightnessctl m)
    # lcdrat=$(echo "scale=2 ; $lcdact / $lcdmax" | bc)
    echo "WCP.SH Brightness ratio $lcdrat"

    echo "WCP.SH Getting bluetooth device"
    # BLUETOOTHCTL - uncomment if you have bluetooth and bluetoothctl
    # btdevice=$(bluetoothctl info | sed -n 2p | awk '{for(i=2;i<=NF;i++) printf $i" "}')
    # if [ ${#btdevice} -eq 0 ]
    # then
    #	btdevice="No_device_connected"
    # fi
    echo "WCP.SH Bluetooth device $btdevice"

    echo "WCP.SH Getting wifi network"
    # NMCLI - uncomment if you use nmcli for wifi
    # network=$(nmcli con show | awk 'NR==2 {print $1}')

    # IWGTK - uncomment if you use iwgtk for wifi
    # network=$(iwctl station wlp0s20f3 show | sed -n 7p | awk '{print $NF}')
    echo "WCP.SH Wifi network $network"

    echo "WCP.SH Getting printer"
    # LPSTAT - uncomment if you use a printer and lpstat 
    # printer=$(lpstat -e)
    echo "WCP.SH Printer $printer"

    echo "WCP.SH Getting layout"
    layout=$(swaymsg -t get_inputs | jq '.[0].xkb_active_layout_name' | sed 's/^.//;s/.$//')
    echo "WCP.SH Layout $layout"

    echo "set ratio div volslider value $volrat" >&3
    echo "set ratio div lcdslider value $lcdrat" >&3
    echo "set text div btoothlabel value $btdevice" >&3
    echo "set text div wifilabel value $network" >&3
    echo "set text div printerlabel value ${printer// /_}" >&3
    echo "set text div keyboardlabel value ${layout// /_}" >&3
}

kuid -v <&3 | while IFS= read -r line; do                     # start kuid with file descriptor 3 as input and pipe its output to a reader

    echo "KUID:" $line
    words=($line)
    if [ ${words[0]} = "event" ]                              # analyze words in kuid output
    then

	if [ ${words[1]} = "init" ]                           # init event arrived
	then

	    echo "WCP.SH Creating layer"
	    echo "create layer width 300 height 258 anchor rt margin 10" >&3
	    echo "load html src ~/.config/wcp/res/main.html" >&3
	    echo "WCP.SH Layer created"
	    
	    update                                            # update sliders and labels

	elif [ ${words[1]} = "update" ]
	then

	    update	                                      # update sliders and labels

	# slider events
	elif [ ${words[1]} == "ratio" ]
	then
	    if [ ${words[3]} == "volslider" ]                 # volume slider moved
	    then

		echo "WCP.SH Setting volume"
		# PACTL - uncomment if you use pactl
		# vol=${words[7]}
		# res=$(pactl set-sink-volume @DEFAULT_SINK@ $vol%) # pactl
		echo "WCP.SH Volume set"

	    elif [ ${words[3]} == "lcdslider" ]               # lcd slider moved
	    then

		echo "WCP.SH Setting brightness"
		# BRIGHTNESSCLT - uncomment if you use brightnessctl
		# lcd=${words[7]}
		# res=$(brightnessctl set $lcd%)                # brightnessctl
		echo "WCP.SH Brightness set"

	    fi

	# button events
	elif [ ${words[1]} == "state" ]
	then
	    if [ ${words[3]} == "mutebtn" ]                   # volume button pressed
	    then

		# PAVUCONTROL - uncomment if you use pavucontrol for volume control
		# swaymsg exec pavucontrol
		pavucontrol

	    elif [ ${words[3]} == "displaybtn" ]              # display button pressed
	    then

		# WDISPLAYS - uncomment if you use wdisplays for display setup
		# swaymsg exec wdisplays
		wdisplays

	    elif [ ${words[3]} == "wifibtn" ] ||
		 [ ${words[3]} == "wifilabelback" ]           # wifi button pressed
	    then

		# IWGTK - uncomment if you use iwftk for wifi setup
		# swaymsg exec iwgtk

		# NMTUI - uncomment if you use nmtui for wifi setup
		# swaymsg exec "foot nmtui"
      
	    elif [ ${words[3]} == "bluetoothbtn" ] ||
		 [ ${words[3]} == "btoothlabelbck" ]          # bluetooth button pressed
	    then                                              

		# BLUEMAN - uncomment if you use blueman-manager for bluetooth setup
		# swaymsg exec blueman-manager

	    elif [ ${words[3]} == "lockbtn" ]                 # lock button pressed
	    then

		# SWAYLOCK - uncomment if you use swaylock
		# swaymsg exec swaylock

	    elif [ ${words[3]} == "logoutbtn" ]               # logout button pressed
	    then

		# SWAY EXIT - uncomment if you use sway exit
		# sway exit

		# LOGINCTL - uncomment if you use loginctl
		# swaymsg exec loginctl terminate-user $USER

	    elif [ ${words[3]} == "suspendbtn" ]              # suspend button pressed
	    then

		# ZZZ - uncomment if you use zz for suspend ( void linux )
		# sudo /sbin/zzz

		# SYSTEMD - uncomment if you use systemd
		# swaymsg exec systemctl suspend
	
	    elif [ ${words[3]} == "rebootbtn" ]               # reboot button pressed
	    then
		
		# REBOOT - uncomment if you use reboot for reboot
		# sudo /sbin/reboot

		# SYSTEMD - uncomment if you use systemd
		# swaymsg exec systemctl reboot

	    elif [ ${words[3]} == "shutdownbtn" ]             # shutdown button pressed
 	    then

		# POWEROFF - uncomment if you use poweroff for poweroff
		# sudo /sbin/poweroff

		# SYSTEMD - uncomment if you use systemd
		# swaymsg exec systemctl poweroff

	    fi
	fi
    fi
done
