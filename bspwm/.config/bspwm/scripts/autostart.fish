#! /bin/fish

set apps "xsettingsd
fcitx5
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
nitrogen --restore; sleep 1; picom -b
nm-applet
clipit
blueman-applet
xidlehook --not-when-audio --not-when-fullscreen --timer 600 "$HOME/.config/bspwm/scripts/i3lock-color.sh"
xss-lock $HOME/.config/bspwm/scripts/i3lock-color.sh
libinput-gestures
$HOME/.config/polybar/launch.fish
picom -b
sh $HOME/.config/bspwm/scripts/bspswallow"
#/opt/clash-for-windows-chinese/cfw"

for app in (string split \n $apps)
    if test (ps -ef | grep "$app" | grep -v grep | wc -l) = 0
       fish -c "$app" &
    end
end

xinput set-prop GXT7863:00\ 27C6:01E0\ Touchpad libinput\ Tapping\ Enabled 1
xinput set-prop GXT7863:00\ 27C6:01E0\ Touchpad libinput\ Accel\ Speed 0.6
xinput set-prop GXT7863:00\ 27C6:01E0\ Touchpad libinput\ Natural\ Scrolling\ Enabled 1
xinput set-prop GXT7863:00\ 27C6:01E0\ Touchpad libinput\ Scrolling\ Pixel\ Distance 20
