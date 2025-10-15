#!/bin/bash

mkdir -p $HOME/yay-install
cd $HOME/yay-install

git clone https://aur.archlinux.org/yay.git
cd yay

echo "⬇️ Installing Yay"
yes | makepkg -sci --noconfirm

aur_packages=(
    brave-bin
    localsend-bin
)

for pkg in "${aur_packages[@]}"; do
    echo "⬇️ Installing $pkg..."
    yay -S --noconfirm "$pkg"
done

sleep 2

cd $HOME
rm -rf yay-install
