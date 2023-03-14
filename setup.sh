#!/bin/bash

echo "For help read https://wiki.archlinux.org/title/Migrate_installation_to_new_hardware"
echo "Running setup script. Assuming you are in a bash shell."
echo "You should have already installed Arch fully without rebooting. For help read https://wiki.archlinux.org/title/Installation_guide"
echo "Press [Enter] to continue with configuration..."
while true; do
  read -s -n 1 input
  if [[ $input = '' ]]; then break; fi
done

HERE=$(dirname "${BASH_SOURCE[0]}")

# Install Asus ROG Zephyrus tools
# ===========================================
while true; do
  read -p "Would you like to install Asus ROG Zephyrus tools? [Y/n]: " yn
  case $yn in
    "[Yy]*"|"" )
      sh ./asus.sh
      break;;
    [Nn]* )
      echo "Skipping Asus tools installation.";
      break;;
    * ) echo "Please answer yes or no.";;
  esac
done

echo "=================================="
echo
# ===========================================


# Install backed up community and Aur packages
# ===========================================
#TODO: Remove drivers not needed on new system from lists
echo "Installing community and Aur packages from pkglist*.txt"
echo "Press [Enter] to continue if you've made sure there aren't any drivers not needed on the new system on the lists..."
while true; do
  read -s -n 1 input
  if [[ $input = '' ]]; then break; fi
done

pacman -S --needed - < pkglistNative.txt
pacman -S --needed - < pkglistAur.txt

echo "Packages done installing."
echo "=================================="
echo
# ===========================================


# Setup bash dotfiles
# ===========================================
echo "Configuring bash dotfiles."
echo "Press [Enter] to continue..."
while true; do
  read -s -n 1 input
  if [[ $input = '' ]]; then break; fi
done

"$HERE"/bash/setup.sh

echo "=================================="
echo

# ===========================================


# Setup i3
# ===========================================
while true; do
  read -p "Would you like to configure i3? [Y/n]: " yn
  case $yn in
    "[Yy]*"|"" )
      "$HERE"/i3/setup.sh
      break;;
    [Nn]* )
      echo "Skipping i3 setup.";
      break;;
    * ) echo "Please answer yes or no.";;
  esac
done

echo "=================================="
echo

# ===========================================


# Setup vim
# ===========================================
while true; do
  read -p "Would you like to configure vim dotfiles from github.com:Samwisemr/vimrc.git? [Y/n]: " yn
  case $yn in
    "[Yy]*"|"" )
      "$HERE"/vim/setup.sh
      break;;
    [Nn]* )
      echo "Skipping vim setup.";
      break;;
    * ) echo "Please answer yes or no.";;
  esac
done

echo "=================================="
echo

# ===========================================


echo "All set up!"
echo "You may want to restart your computer"
