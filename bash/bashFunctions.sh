#!/bin/bash

function lc () {
  cd "$@" && ls
}


function startobfsproxy () {
  command cd /etc/openvpn
  sudo service openvpn stop
  sudo cp /home/sam/vpn/openVPN/obfsproxy_mullvad_linux.conf /etc/openvpn/mullvad_linux.conf
  sudo service openvpn start
  obfsproxy obfs2 socks 127.0.0.1:10194 &
  command cd
}


function stopobfsproxy () {
  command cd /etc/openvpn
  kill `pidof obfsproxy`
  sudo service openvpn stop
  sudo cp /home/sam/vpn/openVPN/mullvad_linux.conf /etc/openvpn/mullvad_linux.conf
  sudo service openvpn start
  command cd
}


function scpuwlinenv () {
  scp -r ${1} smeyerre@linux.student.cs.uwaterloo.ca:${2}
}


function adjustBrightness () {
  if [ $1 = "full" ]; then
    sudo sh -c "echo 425 > /sys/class/backlight/intel_backlight/brightness"
    return ${?}
  fi

  direction=$1
  amount=$2
  typeset -i val=$(cat /sys/class/backlight/intel_backlight/brightness)

  if [ $direction = "inc" ]; then
    sum=$(($val + $amount))
    if [ $sum -gt 425 ]; then
      final=425
    else
      final=$sum
    fi
  elif [ $direction = "dec" ]; then
    difference=$(($val - $amount))
    if [ $difference -lt 20 ]; then
      final=20
    else
      final=$difference
    fi
  fi

  sudo sh -c "echo $final > /sys/class/backlight/intel_backlight/brightness"
  return ${?}
}
