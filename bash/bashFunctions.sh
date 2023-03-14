#!/bin/bash

function lc () {
    cd "$@" && ls
}

function pkgBackup() {
  echo "Backing up community and Aur packages..."
  command cd ~/github/linux-config
  pacman -Qqen > pkglistNative.txt
  echo "Backed up native packages to pkglistNative.txt..."
  pacman -Qqem > pkglistAur.txt
  echo "Backed up Aur packages to pkglistAur.txt..."
  if [[ $(command git diff-index --quiet HEAD) == 0 ]]; then
    command git add ./
    command git commit -m "Packages backup - $(date +"%Y-%m-%d %T")"
    command git push
    echo "Created backup - $(date +"%Y-%m-%d %T")"
  else
    echo "Nothing new to backup..."
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
