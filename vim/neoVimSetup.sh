#!/bin/bash

echo "This requires ssh keys to be setup. Press [Enter] to continue once you've setup ssh..."
while true; do
  read -s -n 1 input
  if [[ $input = '' ]]; then break; fi
done

git clone git@github.com:smeyerre/vim-config.git ~/.vim-config
sh ~/.vim-config/setup.sh

echo "Neovim set up!"

