#!/bin/bash

# adding some kde globals
./kde_globals.sh

# adding some kde globals for root user
sudo ./kde_globals_root.sh

# enabling bluetooth autoconnect
sudo ./bluetooth_autoconnect.sh

# Fixing XDG default apps for Arch/KDE
sudo ./default_apps_fix.sh

# mpv mpris support
mkdir -p ~/.config/mpv
ln -sf /usr/lib/mpv-mpris/mpris.so ~/.config/mpv/

# pipewire-jack instead of jack2
sudo pacman -Rns jack2 --noconfirm
sudo pacman -S pipewire-jack --noconfirm

# grub config
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "rebooting..."
sleep 2

reboot

