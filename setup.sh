#!/usr/bin/env bash

# update user home dirs
xdg-user-dirs-update

# fix Broadcom Inc. and subsidiaries BCM4360
./scripts/broadcom_bcm4360_fix.sh
sleep 2

# pacman configuration
sudo ./scripts/pacman_conf.sh
sleep 2

# installing needed packages
sudo ./scripts/install_packages.sh
sleep 2

# installing custom,yay and aur packages
./scripts/install_aur_packages.sh
sleep 2

# select default theme
./scripts/theme.sh
sleep 2

# detect GPU and install necessary packages
./scripts/gpu_setup.sh
sleep 2

# xdg-desktop-portal config
sudo mkdir -p /etc/xdg/xdg-desktop-portal
sudo bash -c 'echo -e "[preferred]\ndefault = hyprland;kde;gtk\norg.freedesktop.impl.portal.FileChooser=kde" > /etc/xdg/xdg-desktop-portal/portals.conf'

# greetd auto-login config --> hyprlock
envsubst < greetd/config.toml.in > greetd/config.toml
sudo cp ./greetd/config.toml /etc/greetd
sudo ./scripts/greetd_kwallet.sh
mkdir -p $HOME/.local/share/dbus-1/services
echo -e '[D-BUS Service]\nName=org.freedesktop.secrets\nExec=/usr/bin/kwalletd6' > $HOME/.local/share/dbus-1/services/org.freedesktop.secrets.service

# starship & fastfetch >> .bashrc
echo 'fastfetch --config $HOME/.config/kitty/fastfetch/config.jsonc' >> ~/.bashrc
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# aliases
echo "alias ls='eza -all'" >> ~/.bashrc

# QEMU Setup
./scripts/qemu_setup.sh

# load needed kernel modules
sudo modprobe i2c-dev # for ddcutil

# enable systemd services
sudo systemctl enable bluetooth.service
sudo systemctl enable firewalld.service
sudo systemctl enable greetd.service

echo "rebooting..."
sleep 2
reboot

