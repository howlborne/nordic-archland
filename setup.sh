#!/bin/bash

xdg-user-dirs-update

# Installing needed packages
sudo ./install_packages.sh

# Installing yay and aur packages
./install_aur_packages.sh

# Copying .config files
mkdir -p $HOME/.config
cp -r ./alacritty ./btop ./hypr ./waybar ./rofi ./xdg-desktop-portal $HOME/.config

# Copying wallpapers
cp ./Pictures/* $HOME/Pictures

# Copying cursors
sudo cp -r ./Cursors/Nordzy-hyprcursors /usr/share/icons

# Applying Utterly Nord Color Scheme for KDE Apps
#Color-Scheme
mkdir -p ~/.local/share/color-schemes
cp ./Themes/Utterly-Nord-Plasma/UtterlyNord.colors ~/.local/share/color-schemes

# Applying Nordic theme for GTK3/4
sudo cp -r ./Themes/Nordic-bluish-accent ./Themes/Nordic-bluish-accent-v40 /usr/share/themes
cp ./Themes/gtk-3.0/settings.ini $HOME/.config/gtk-3.0
cp ./Themes/gtk-4.0/settings.ini $HOME/.config/gtk-4.0

# Fix for Broadcom Inc. and subsidiaries BCM4360 802.11ac Dual Band Wireless Network Adapter (rev 03)
sudo cp ./broadcom-wl-dkms.conf /etc/modprobe.d
sudo mkinitcpio -p linux-lts

# Load needed kernel modules
sudo modprobe i2c-dev

# Enable systemd services
sudo systemctl enable bluetooth.service
sudo systemctl enable firewalld.service

reboot

