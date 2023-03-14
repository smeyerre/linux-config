#!/bin/bash

# From https://asus-linux.org/wiki/arch-guide/#installing
# Specific setup for ROG Zephyrus laptops

echo "Installing Asus ROG Zephyrus tools"

pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35

command echo "\n[g14]\nServer = https://arch.asus-linux.org" >> /etc/pacman.conf

pacman -Syu
pacman -S asusctl supergfxctl rog-control-center

systemctl enable --now power-profiles-daemon.service
systemctl enable --now supergfxd

echo "Asus ROG Zephyrus tools all set up!"
