setxkbmap -layout 'us,ru(winkeys)' -option 'grp:caps_toggle,grp_led:caps,grp:switch,compose:menu'

xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 8 6 7 4 5

ssh-agent /usr/bin/awesome
