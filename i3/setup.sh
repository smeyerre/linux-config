#!/bin/bash

HERE=$(dirname "${BASH_SOURCE[0]}")

command cp $HERE/config ~/.config/i3/config
command cp -r $HERE/bin ~/.config/i3/
command cp -r $HERE/i3blocks/blocklets ~/.config/i3/
command cp $HERE/fehbg ~/.fehbg
command cp $HERE/i3blocks/i3blocks.conf /etc/i3blocks.conf
command cp $HERE/windows-xp-bliss-4k-lu-2560x1440.jpg ~/Pictures
command cp $HERE/lockscreen.png ~/Pictures

echo "i3 files set up!"
