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
sudo cp -r ./Nordzy-hyprcursors ./Nordic-cursors /usr/share/icons

# Applying Utterly Nord Color Scheme for KDE Apps
# Look-and-Feel
mkdir -p ~/.local/share/plasma/look-and-feel/Utterly-Nord
tar -xJf ./Utterly-Nord-Plasma/Utterly-Nord.tar.xz -C ~/.local/share/plasma/look-and-feel/Utterly-Nord
#Color-Scheme
mkdir -p ~/.local/share/color-schemes
tar -xzf ./Utterly-Nord-Plasma/Utterly-Nord-Colors.tar.gz -C ~/.local/share/color-schemes


# Setting some KDE Globals
./kde_globals.sh

