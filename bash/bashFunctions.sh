#!/bin/bash

function lc () {
    cd "$@" && ls
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
