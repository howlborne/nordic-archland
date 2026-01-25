#!/usr/bin/env bash

cd Packages/python-iniparse

echo "⬇️ Installing python-iniparse"
yes | makepkg -sci --noconfirm

sleep 2

mkdir -p $HOME/yay-install
cd $HOME/yay-install

git clone https://aur.archlinux.org/yay.git
cd yay

echo "⬇️ Installing Yay"
yes | makepkg -sci --noconfirm

sleep 2

aur_packages=(
    crudini
    brave-bin
    localsend-bin
)

for pkg in "${aur_packages[@]}"; do
    echo "⬇️ Installing $pkg..."
    yay -S --noconfirm "$pkg"
    sleep 2
done

sleep 2

rm -rf $HOME/yay-install
