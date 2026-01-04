#!/bin/bash

echo "Fixing default apps launch..."

pacman -S archlinux-xdg-menu --noconfirm

update-desktop-database

cd /etc/xdg/menus

mv arch-applications.menu applications.menu

kbuildsycoca6 --noincremental

echo "Done!"
