#!/bin/bash

HERE=$(dirname "${BASH_SOURCE[0]}")

if [ -f ~/.tmux.conf ]; then
  echo "A tmux conf already exists on this computer!"
else
  cp $HERE/tmux.conf ~/.tmux.conf
  echo "tmux set up!"
fi

