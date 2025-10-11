#!/bin/bash

echo "🛠️ Making AUR Directory"
mkdir $HOME/AUR
cd $HOME/AUR

git clone https://aur.archlinux.org/yay.git
cd yay

echo "⬇️ Installing Yay"
yes | makepkg -sci --noconfirm

aur_packages=(
    brave-bin
    hyprshot
    localsend-bin
)

for pkg in "${aur_packages[@]}"; do
    echo "⬇️ Installing $pkg..."
    yay -S --noconfirm "$pkg"
done

cd $HOME
rm -r ./AUR
