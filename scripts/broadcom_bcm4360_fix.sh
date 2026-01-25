#!/usr/bin/env bash

# Fix for Broadcom Inc. and subsidiaries BCM4360 802.11ac Dual Band Wireless Network Adapter (rev 03)
if lspci -n | grep -qi "14e4:43a0"; then
    echo "Broadcom Inc. BCM4360 detected..."
    sudo pacman -S --noconfirm broadcom-wl-dkms

    sudo cp ./broadcom-wl-dkms.conf /etc/modprobe.d
    sudo mkinitcpio -p linux-lts
fi


