#!/bin/bash

sudo pacman -Sy qemu-full libvirt dnsmasq virt-manager

sudo usermod -aG libvirt,kvm $USER

sudo systemctl enable libvirtd
