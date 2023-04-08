#!/bin/sh
xrandr --newmode "1024x600_60.00" 49.00 1024 1029 1042 1312 600 602 605 622 -HSync +VSync
xrandr --addmode DP-1 "1024x600_60.00"
xrandr --output DP-1 --mode "1024x600_60.00"
cd /home
./app
