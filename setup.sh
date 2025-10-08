#!/bin/bash

xdg-user-dirs-update

# Installing needed packages
sudo ./install_packages.sh

# Installing yay and aur packages
./install_aur_packages.sh

# Copying .config files
mkdir -p $HOME/.config
cp -r ./kitty ./btop ./dunst ./fastfetch ./hypr ./waybar ./rofi ./starship ./xdg-desktop-portal $HOME/.config

# for root user
sudo cp -r ./kitty ./btop ./dunst ./fastfetch ./hypr ./waybar ./rofi ./starship ./xdg-desktop-portal /root/.config

# greetd config file for my user //change for yours//
sudo cp ./greetd/config.toml /etc/greetd

# Copying wallpapers
mkdir -p $HOME/Pictures/hyprpaper-wallpapers
cp ./Pictures/* $HOME/Pictures/hyprpaper-wallpapers

# Copying wallpapers for root user
sudo mkdir -p /root/Pictures/hyprpaper-wallpapers
sudo cp ./Pictures/* /root/Pictures/hyprpaper-wallpapers

# Copying cursors
sudo cp -r ./Cursors/Nordzy-hyprcursors /usr/share/icons

# Applying Utterly Nord Color Scheme for KDE Apps
#Color-Scheme
sudo cp ./Themes/Utterly-Nord-Plasma/UtterlyNord.colors /usr/share/color-schemes

# Nordzy-dark icons
sudo cp -r ./Themes/Nordzy-dark /usr/share/icons

# Applying Nordic theme for GTK3/4
sudo cp -r ./Themes/Nordic-bluish-accent ./Themes/Nordic-bluish-accent-v40 /usr/share/themes
mkdir -p $HOME/.config/gtk-3.0
mkdir -p $HOME/.config/gtk-4.0
cp ./Themes/gtk-3.0/settings.ini $HOME/.config/gtk-3.0
cp ./Themes/gtk-4.0/settings.ini $HOME/.config/gtk-4.0
# for root user
sudo cp ./Themes/gtk-3.0/settings.ini /root/.config/gtk-3.0
sudo cp ./Themes/gtk-4.0/settings.ini /root/.config/gtk-4.0

# starship & fastfetch >> .bashrc
echo 'fastfetch --config $HOME/.config/kitty/fastfetch/config.jsonc' >> ~/.bashrc
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Fix for Broadcom Inc. and subsidiaries BCM4360 802.11ac Dual Band Wireless Network Adapter (rev 03)
sudo cp ./broadcom-wl-dkms.conf /etc/modprobe.d
sudo mkinitcpio -p linux-lts

# Load needed kernel modules
sudo modprobe i2c-dev

# Enable systemd services
sudo systemctl enable bluetooth.service
sudo systemctl enable firewalld.service
sudo systemctl enable greetd.service
sudo systemctl enable cronie.service

echo "rebooting..."
sleep 2
reboot

