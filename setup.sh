#!/bin/bash

HERE=$(dirname "${BASH_SOURCE[0]}")

sudo apt-get install vim-gnome
sudo apt-get install i3
#sudo apt-get install tmux

"$HERE"/bash/setup.sh
"$HERE"/i3/setup.sh
"$HERE"/i3status/setup.sh
#"$HERE"/tmux/setup.sh
"$HERE"/vim/setup.sh

echo "All set up!"
echo "You may want to restart your computer"
