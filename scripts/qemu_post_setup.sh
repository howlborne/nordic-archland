#!/usr/bin/env bash
if sudo pacman -Q | grep -q "libvirt"; then
    sudo virsh net-start default
    sudo virsh net-autostart default
fi
