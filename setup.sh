#!/bin/bash

xdg-user-dirs-update

# Installing needed packages
sudo ./install_packages.sh

# Installing yay and aur packages
./install_aur_packages.sh

# Fixing XDG default apps for Arch/KDE
sudo ./default_apps_fix.sh

# Copying .config files
mkdir -p $HOME/.config
cp -r ./alacritty ./btop ./hypr ./waybar ./xdg-desktop-portal $HOME/.config

# Copying wallpapers
cp ./Pictures/* $HOME/Pictures

# Copying cursors
sudo cp -r ./Cursors/Nordzy-hyprcursors /usr/share/icons

# Applying Utterly Nord Color Scheme for KDE Apps
# Look-and-Feel
mkdir -p ~/.local/share/plasma/look-and-feel/Utterly-Nord
tar -xJf ./Themes/Utterly-Nord-Plasma/Utterly-Nord.tar.xz -C ~/.local/share/plasma/look-and-feel/Utterly-Nord
#Color-Scheme
mkdir -p ~/.local/share/color-schemes
tar -xzf ./Themes/Utterly-Nord-Plasma/Utterly-Nord-Colors.tar.gz -C ~/.local/share/color-schemes

# Applying Nordic theme for GTK3/4
sudo cp -r ./Themes/Nordic-bluish-accent ./Themes/Nordic-bluish-accent-v40 /usr/share/themes
cp ./Themes/settings.ini $HOME/.config/gtk-3.0
cp ./Themes/settings.ini $HOME/.config/gtk-4.0

# Fix for Broadcom Inc. and subsidiaries BCM4360 802.11ac Dual Band Wireless Network Adapter (rev 03)
sudo cp ./broadcom-wl-dkms.conf /etc/modprobe.d
sudo mkinitcpio -p linux-lts

# Load needed kernel modules
sudo modprobe i2c-dev

# Enable systemd services
sudo systemctl enable bluetooth.service
sudo systemctl enable firewalld.service

reboot

