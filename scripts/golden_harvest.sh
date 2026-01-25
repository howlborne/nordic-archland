#!/usr/bin/env bash

THEMES=$HOME/.local/share/archland/global-themes

# symlink .config dirs
    for dir in $THEMES/golden-harvest/.config/*/; do
        name=${dir%/}
        name=${name##*/}
        if [ -d $HOME/.config/$name ]; then
            rm -r $HOME/.config/$name
            ln -sf $THEMES/golden-harvest/.config/$name $HOME/.config/
        else
            ln -sf $THEMES/golden-harvest/.config/$name $HOME/.config/
        fi
    done

    # symlink wallpaper
    ln -sf $THEMES/golden-harvest/Pictures/background.png $HOME/Pictures/hyprpaper-wallpapers/

    # apply GoldenHarvest KDE theme
    plasma-apply-colorscheme GoldenHarvest
    kwriteconfig6 --file kdeglobals --group Icons --key Theme GoldenHarvest

    # apply GoldenHarvest GTK theme
#     crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-theme-name GoldenHarvest-v40
    crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-icon-theme-name GoldenHarvest
    crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-cursor-theme-name GoldenHarvest-cursors
#     crudini --set ~/.config/gtk-4.0/settings.ini Settings gtk-theme-name GoldenHarvest-v40
    crudini --set ~/.config/gtk-4.0/settings.ini Settings gtk-icon-theme-name GoldenHarvest
    crudini --set ~/.config/gtk-4.0/settings.ini Settings gtk-cursor-theme-name GoldenHarvest-cursors
    gsettings set org.gnome.desktop.interface icon-theme "GoldenHarvest"
    gsettings set org.gnome.desktop.interface cursor-theme "GoldenHarvest-cursors"
#     gsettings set org.gnome.desktop.interface gtk-theme 'GoldenHarvest-v40'

# restart hyprland
hyprctl dispatch exit
