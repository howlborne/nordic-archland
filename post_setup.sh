#!/bin/bash

# adding some kde globals
./kde_globals.sh

# enabling bluetooth autoconnect
sudo ./bluetooth_autoconnect.sh

# Fixing XDG default apps for Arch/KDE
sudo ./default_apps_fix.sh

# mpv mpris support
mkdir -p ~/.config/mpv
ln -sf /usr/lib/mpv-mpris/mpris.so ~/.config/mpv/

# pipewire-jack instead of jack2
yes | sudo pacman -S pipewire-jack --noconfirm

reboot
