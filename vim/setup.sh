#!/bin/bash

echo "Setting up vim..."
echo "This requires ssh keys to be setup. Press [Enter] to continue once you've setup ssh..."
while true; do
  read -s -n 1 input
  if [[ $input = '' ]]; then break; fi
done

git clone git@github.com:Samwisemr/vimrc.git ~/.vim-runtime
sh ~/.vim-runtime/install_awesome_vimrc.sh

echo "vim set up!"
