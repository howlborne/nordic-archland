#!/usr/bin/env bash

# apply KDE default theme
if [[ "$(cat /tmp/archland_default)" == "Golden Harvest" ]]; then
    plasma-apply-colorscheme GoldenHarvest
else
    plasma-apply-colorscheme Nordveil
fi

# time sync
sudo timedatectl set-ntp true

# enabling bluetooth autoconnect
sudo ./bluetooth_autoconnect.sh

# fix XDG default apps for Arch/KDE
sudo ./default_apps_fix.sh

# mpv mpris support
mkdir -p ~/.config/mpv
ln -sf /usr/lib/mpv-mpris/mpris.so ~/.config/mpv/

# set ddcutil monitor bus
./gen_ddcutil_bus_brightness.sh

# pipewire-jack instead of jack2
yes | sudo pacman -S pipewire-jack --noconfirm

# fix files associations
./default_mimeapps.sh

# hiding unneeded applications from rofi drun...
sudo ./hide_unneeded_rofi_drun_apps.sh

# QEMU post setup
./qemu_post_setup.sh

# hyprpolkitagent build with better UI
./hyprpolkitagent_rebuild.sh

# grub config
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "rebooting..."
sleep 2

reboot

