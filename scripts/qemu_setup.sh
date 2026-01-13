#!/bin/bash

read -p "Do you want QEMU/KVM Virtual Machine setup? (y/n) " RESPONSE
RESPONSE=${RESPONSE,,}

if [[ "$RESPONSE" == "y" ]]; then
    echo "Installing QEMU/KVM..."
    sudo pacman -Sy qemu-full libvirt dnsmasq virt-manager
    sudo usermod -aG libvirt,kvm $USER
    sudo systemctl enable libvirtd
else
    echo "Exiting QEMU/KVM setup!"
fi
