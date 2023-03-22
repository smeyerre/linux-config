#!/bin/bash

echo "Setting up i3..."

HERE=$(dirname "${BASH_SOURCE[0]}")

command cp $HERE/config ~/.config/i3/config
command cp -r $HERE/bin ~/.config/i3/
command cp -r $HERE/i3blocks/blocklets ~/.config/i3/
command cp $HERE/i3blocks/i3blocks.conf /etc/i3blocks.conf
command cp $HERE/wallpaper.jpg $HERE/lockscreen.png ~/Pictures

# Setup betterlockscreen to lock on sleep/suspend
command mkdir -p ~/.config/betterlockscreen/
command cp /usr/share/doc/betterlockscreen/examples/betterlockscreenrc ~/.config/betterlockscreen/
systemctl enable betterlockscreen@$USER

# Setup Rofi
while true; do
  read -p "Would you like to import the rofi configuration? [Y/n]: " yn
  case $yn in
    "[Yy]*"|"" )
      command cp -r $HERE/rofi ~/.config/
      break;;
    [Nn]* )
      echo "Skipping rofi config import.";
      break;;
    * ) echo "Please answer yes or no.";;
  esac
done

# Setup Picom
while true; do
  read -p "Would you like to import the picom configuration? [Y/n]: " yn
  case $yn in
    "[Yy]*"|"" )
      command cp -r $HERE/picom ~/.config/
      break;;
    [Nn]* )
      echo "Skipping picom config import.";
      break;;
    * ) echo "Please answer yes or no.";;
  esac
done

echo "i3 files set up!"
