#!/bin/bash

rofi_command="rofi -theme ~/.config/bspwm/scripts/rofi/powermenu.rasi"

#### Options ###
shutdown=
reboot=""
lock=""
suspend="鈴"
logout=""

options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $lock)
        ~/.config/bspwm/.config/bspwm/scripts/i3lock-color.sh
	      ;;    
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $suspend)
	      mpc -q pause
	      amixer set Master mute
	      systemctl suspend
        ;;
    $logout)
        loginctl terminate-session ${XDG_SESSION_ID-}	
	;;
esac

