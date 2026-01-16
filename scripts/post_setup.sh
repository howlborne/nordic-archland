#!/bin/bash

# adding some kde globals
./kde_globals.sh

# adding some kde globals for root user
#sudo ./kde_globals_root.sh

# enabling bluetooth autoconnect
sudo ./bluetooth_autoconnect.sh

# Fixing XDG default apps for Arch/KDE
sudo ./default_apps_fix.sh

# mpv mpris support
mkdir -p ~/.config/mpv
ln -sf /usr/lib/mpv-mpris/mpris.so ~/.config/mpv/

# setting ddcutil monitor bus and generating script for waybar
./gen_ddcutil_bus_brightness.sh

# pipewire-jack instead of jack2
sudo pacman -S pipewire-jack

# fixing files opening to Dolphin instead of terminal
./default_mimeapps.sh

# hiding unneeded applications from rofi drun...
sudo ./hide_unneeded_rofi_drun_apps.sh

# QEMU Post Setup
./qemu_post_setup.sh

# hyprpolkitagent build with better UI
git clone https://github.com/hyprwm/hyprpolkitagent.git
cp ../hyprpolkitagent-qml/main.qml ./hyprpolkitagent/qml/
cd hyprpolkitagent
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
sleep 1
make
sleep 1
sudo make install
cd ../..
rm -rf hyprpolkitagent

# grub config
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "rebooting..."
sleep 2

reboot

