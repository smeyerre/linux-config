#!/bin/bash -x

function stopobfsproxy () {
  command cd /etc/openvpn
  kill `pidof obfsproxy`
  sudo service openvpn stop
  sudo cp /home/sam/vpn/openVPN/mullvad_linux.conf /etc/openvpn/mullvad_linux.conf
  sudo service openvpn start
  command cd
}
