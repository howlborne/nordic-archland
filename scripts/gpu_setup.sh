#!/bin/bash

if lspci -nn | grep -qi "1002:"; then
    echo "AMD GPU detected..."
    echo "Installing necessary packages..."

    sudo pacman -S vulkan-radeon lib32-vulkan-radeon xf86-video-amdgpu rocm-opencl-runtime --noconfirm
fi

if lspci -nn | grep -i 'VGA' | grep -q '8086'; then
    echo "Intel iGPU detected..."
    echo "Installing necessary packages..."

    sudo pacman -S vulkan-intel intel-media-driver --noconfirm
fi
