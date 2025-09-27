#!/bin/bash

pacman -S archlinux-xdg-menu --noconfirm

update-desktop-database

cd /etc/xdg/menus

mv arch-applications.menu applications.menu

kbuildsycoca6 --noincremental
