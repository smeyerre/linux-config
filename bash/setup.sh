#!/bin/bash

HERE=$(dirname "${BASH_SOURCE[0]}")

command cp $HERE/bashrc ~/.bashrc
command cp $HERE/bash_prompt ~/bash_prompt
command cp $HERE/bash_aliases ~/.bash_aliases
command cp $HERE/profile ~/.profile
command cp $HERE/commands ~/commands

command mkdir -p ~/bin
command cp $HERE/bin/* ~/bin/

echo "Bash files set up!"
