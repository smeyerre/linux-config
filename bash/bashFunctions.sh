#!/bin/bash

function lc () {
    cd "$@" && ls
}

function pkgBackup() {
  bold=$(tput bold)
  normal=$(tput sgr0)
  echo "Backing up community and Aur packages..."
  command cd ~/github/linux-config

  echo "${bold}Retrieving native packages...${normal}"
  newpkgsNative=$(pacman -Qqen | comm -13 pkglistNative.txt -)
  removedpkgsNative=$(pacman -Qqen | comm -23 pkglistNative.txt -)
  if [[ -z "$newpkgsNative" ]]; then newpkgsNative="N/A"; fi
  if [[ -z "$removedpkgsNative" ]]; then removedpkgsNative="N/A"; fi
  echo "  New native packages..."
  echo "$(echo $newpkgsNative | sed 's/^/    /')"
  echo "  Removed native packages..."
  echo "$(echo $removedpkgsNative | sed 's/^/    /')"
  echo

  echo "${bold}Retrieving Aur packages...${normal}"
  newpkgsAur=$(pacman -Qqem | comm -13 pkglistAur.txt -)
  removedpkgsAur=$(pacman -Qqem | comm -23 pkglistAur.txt -)
  if [[ -z "$newpkgsAur" ]]; then newpkgsAur="N/A"; fi
  if [[ -z "$removedpkgsAur" ]]; then removedpkgsAur="N/A"; fi
  echo "  New Aur packages..."
  echo "$(echo $newpkgsAur | sed 's/^/    /')"
  echo "  Removed Aur packages..."
  echo "$(echo "$removedpkgsAur" | sed 's/^/    /')"
  echo

  echo "${bold}Writing native packages to pkglistNative.txt...${normal}"
  pacman -Qqen > pkglistNative.txt
  echo "${bold}Writing Aur packages to pkglistAur.txt...${normal}"
  pacman -Qqem > pkglistAur.txt

  if [[ `git status --porcelain pkglist*.txt` ]]; then
    command git add ./
    command git commit -m "Packages backup - $(date +"%Y-%m-%d %T")"
    command git push
    echo "${bold}Created backup - $(date +"%Y-%m-%d %T")${normal}"
  else
    echo "${bold}Did not backup.${normal}"
  fi
  command cd -
  echo "Done!"
}

function fixRazerMouseSpeed () {
  xinput --set-prop "pointer:Razer Razer DeathAdder 2013" "libinput Accel Speed" -0.4
}

function findstr () {
    str=${1}
    if [ "$str" = "--help" -o "$str" = "" ]; then
        command echo -e "Usage: findstr [--help] [ \e[4mSTRING\e[0m [\e[4mFILTER\e[0m]... ]\n"
        command echo -e "Description:"
        command echo -e "   Look for \e[4mSTRING\e[0m in files matching the \e[4mFILTER\e[0m types\n"
        command echo -e "Options:"
        command echo -e "   --help  display this help"
    else
        shift

        filters="${1}"
        shift
        while [ "${1}" != "" ]; do
            filters="$filters,${1}"
            shift
        done

        if [ "$filters" = "" ]; then
            find . -print0 | xargs -0 egrep -e "$str"
        else
            find . -name "*.[$filters]" -print0 | xargs -0 egrep -e "$str"
        fi
    fi
}

# function scpuwlinenv () {
#   scp -r ${1} smeyerre@linux.student.cs.uwaterloo.ca:${2}
# }

# function fixRazerMouseSpeed () {
#   id=`xinput list | egrep "Razer DeathAdder 2013" | head -1 | sed "s/id=/&#####/" | sed "s/.*#####//" | sed "s/\t/#####&/" | sed "s/#####.*$//"`

#   xinput --set-prop $id "Device Accel Constant Deceleration" 2
#   xinput --set-prop $id "Device Accel Velocity Scaling" 7
# }
