#!/usr/bin/env bash

read -p "Do you want QEMU/KVM Virtual Machine setup? (y/n) " RESPONSE
RESPONSE=${RESPONSE,,}

if [[ "$RESPONSE" == "y" ]]; then
    echo "Installing QEMU/KVM..."
    sudo pacman -Sy qemu-desktop libvirt dnsmasq virt-manager --noconfirm
    sleep 2
    sudo usermod -aG libvirt,libvirt-qemu,kvm $USER
    sudo systemctl enable libvirtd
else
    echo "Exiting QEMU/KVM setup!"
fi
