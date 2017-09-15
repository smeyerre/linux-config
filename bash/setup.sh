#!/bin/bash

HERE=$(dirname "${BASH_SOURCE[0]}")

command cp $HERE/bashrc ~/.bashrc
command cp $HERE/bash_prompt ~/.bash_prompt
command cp $HERE/bash_aliases ~/.bash_aliases
command cp $HERE/profile ~/.profile
command cp $HERE/dope_commands ~/dope_commands

command cp $HERE/fehbg ~/.fehbg
command chmod a+x ~/.fehbg

command mkdir -p ~/bin
command cp $HERE/bashFunctions.sh ~/bin/bashFunctions.sh

echo "Bash files set up!"
