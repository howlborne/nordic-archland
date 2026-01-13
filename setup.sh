#!/bin/bash

xdg-user-dirs-update

# Broadcom Inc. and subsidiaries BCM4360 fix
./scripts/broadcom_bcm4360_fix.sh

# pacman.conf
sudo ./scripts/pacman_conf.sh

sleep 2

# Installing needed packages
sudo ./scripts/install_packages.sh

sleep

# Installing yay and aur packages
./scripts/install_aur_packages.sh

sleep 2

# Detect GPU and install necessary packages
./scripts/gpu_setup.sh

# Copying .config files
mkdir -p $HOME/.config
cp -r ./kitty ./btop ./dunst ./fastfetch ./hypr ./waybar ./rofi ./starship $HOME/.config

#xdg-desktop-portal config fort all users
sudo cp -r ./xdg-desktop-portal /etc/xdg/

# for root user
#sudo cp -r ./kitty ./btop ./dunst ./fastfetch ./hypr ./waybar ./rofi ./starship /root/.config

# greetd config for auto-login to hyprland lockscreen(hyprlock)
./scripts/greetd_conf_gen.sh
sudo cp ./greetd/config.toml /etc/greetd

# Copying wallpapers
mkdir -p $HOME/Pictures/hyprpaper-wallpapers
cp ./Pictures/* $HOME/Pictures/hyprpaper-wallpapers

# Copying wallpapers for root user
#sudo mkdir -p /root/Pictures/hyprpaper-wallpapers
#sudo cp ./Pictures/* /root/Pictures/hyprpaper-wallpapers

# Copying cursors and backing up defaults
sudo cp -r ./Cursors/Nordzy-hyprcursors /usr/share/icons
sudo mkdir -p /usr/share/icons/cursors-backup/Adwaita; sudo mv /usr/share/icons/breeze_cursors /usr/share/icons/Breeze_Light /usr/share/icons/cursors-backup; sudo mv /usr/share/icons/Adwaita/cursors /usr/share/icons/cursors-backup/Adwaita

# Installing Utterly Nord Color Scheme for KDE Apps
#Color-Scheme
sudo cp ./Themes/plasma-themes/Utterly-Nord-Plasma/UtterlyNord.colors /usr/share/color-schemes

# Nordzy-dark icons
sudo cp -r ./Icons/Nordzy-dark /usr/share/icons

# Applying Nordic theme for GTK3/4
sudo cp -r ./Themes/gtk-themes/Nordic-bluish-accent ./Themes/gtk-themes/Nordic-bluish-accent-v40 /usr/share/themes
mkdir -p $HOME/.config/gtk-3.0
mkdir -p $HOME/.config/gtk-4.0
cp ./Themes/gtk-themes/gtk-3.0/settings.ini $HOME/.config/gtk-3.0
cp ./Themes/gtk-themes/gtk-4.0/settings.ini $HOME/.config/gtk-4.0
# for root user
#sudo mkdir -p /root/.config/gtk-3.0
#sudo mkdir -p /root/.config/gtk-4.0
#sudo cp ./Themes/gtk-themes/gtk-3.0/settings.ini /root/.config/gtk-3.0
#sudo cp ./Themes/gtk-themes/gtk-4.0/settings.ini /root/.config/gtk-4.0

# starship & fastfetch >> .bashrc
echo 'fastfetch --config $HOME/.config/kitty/fastfetch/config.jsonc' >> ~/.bashrc
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# aliases
echo "alias ls='eza -all'" >> ~/.bashrc

# QEMU Setup
./scripts/qemu_setup.sh

# Load needed kernel modules
sudo modprobe i2c-dev # for ddcutil

# Enable systemd services
sudo systemctl enable bluetooth.service
sudo systemctl enable firewalld.service
sudo systemctl enable greetd.service

echo "rebooting..."
sleep 2
reboot

