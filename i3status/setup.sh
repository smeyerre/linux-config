#!/bin/bash

HERE=$(dirname "${BASH_SOURCE[0]}")

if [ -f ~/.config/i3status/config ]; then
  echo "An i3status config already exists on this computer!"
  exit 1
else
  command mkdir -p ~/.config/i3status
  command cp $HERE/config ~/.config/i3status/config
  echo "i3status set up!"
fi
