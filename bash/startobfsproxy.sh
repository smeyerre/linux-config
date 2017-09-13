#!/bin/bash -x

function startobfsproxy () {
  command cd /etc/openvpn
  sudo service openvpn stop
  sudo cp /home/sam/vpn/openVPN/obfsproxy_mullvad_linux.conf /etc/openvpn/mullvad_linux.conf
  sudo service openvpn start
  obfsproxy obfs2 socks 127.0.0.1:10194 &
  command cd
}
