#!/usr/bin/env bash

THEMES=$HOME/.local/share/archland/global-themes

# symlink .config dirs
    for dir in $THEMES/nordveil/.config/*/; do
        name=${dir%/}
        name=${name##*/}
        if [ -d $HOME/.config/$name ]; then
            rm -r $HOME/.config/$name
            ln -sf $THEMES/nordveil/.config/$name $HOME/.config/
        else
            ln -sf $THEMES/nordveil/.config/$name $HOME/.config/
        fi
    done

    # symlink wallpaper
    ln -sf $THEMES/nordveil/Pictures/background.png $HOME/Pictures/hyprpaper-wallpapers/

    # apply Nordveil KDE theme
    plasma-apply-colorscheme Nordveil
    kwriteconfig6 --file kdeglobals --group Icons --key Theme Nordveil

    # apply Nordveil GTK theme
    crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-theme-name Nordveil-v40
    crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-icon-theme-name Nordveil
    crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-cursor-theme-name Nordveil-cursors
    crudini --set ~/.config/gtk-4.0/settings.ini Settings gtk-theme-name Nordveil-v40
    crudini --set ~/.config/gtk-4.0/settings.ini Settings gtk-icon-theme-name Nordveil
    crudini --set ~/.config/gtk-4.0/settings.ini Settings gtk-cursor-theme-name Nordveil-cursors
    gsettings set org.gnome.desktop.interface icon-theme "Nordveil"
    gsettings set org.gnome.desktop.interface cursor-theme "Nordveil-cursors"
    gsettings set org.gnome.desktop.interface gtk-theme 'Nordveil-v40'

# restart hyprland -> since we are using greetd auto-login, logging out actually restarts hyprland
loginctl terminate-session $XDG_SESSION_ID
