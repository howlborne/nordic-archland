#!/usr/bin/env bash

THEMES=$HOME/.local/share/archland/global-themes

mkdir -p $THEMES
mkdir -p $HOME/Pictures/hyprpaper-wallpapers
mkdir -p $HOME/.config/gtk-3.0
mkdir -p $HOME/.config/gtk-4.0

# Nordveil & Golden Harvest
cp -r ./global-themes/* $THEMES

# theme switching scripts
cp ./scripts/golden_harvest.sh ./scripts/nordveil.sh $THEMES/scripts/
sudo cp ./scripts/theme_switcher.sh /usr/local/bin

# Icons
sudo cp -r $THEMES/nordveil/Icons/* $THEMES/golden-harvest/Icons/* /usr/share/icons/

# Cursors
sudo cp -r $THEMES/nordveil/Cursors/* $THEMES/golden-harvest/Cursors/* /usr/share/icons/

# KDE color-schemes
sudo cp -r $THEMES/nordveil/KDE/*.colors $THEMES/golden-harvest/KDE/*.colors /usr/share/color-schemes/

# GTK themes
sudo cp -r $THEMES/nordveil/GTK/* $THEMES/golden-harvest/GTK/* /usr/share/themes/


read -p $'Which theme do you want to set by default?\n(1)Nordveil    (Default)\n(2)Golden Harvest\n> ' SELECTED

if [[ "$SELECTED" -eq 2 ]]; then
    echo "Installing Golden Harvest..."

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
else
    echo "Installing Nordveil..."

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
fi

## KDE config ##
kwriteconfig6 --file kdeglobals --group General --key TerminalApplication "kitty"
kwriteconfig6 --file kdeglobals --group General --key XftHintStyle "hintslight"
kwriteconfig6 --file kdeglobals --group General --key XftSubPixel "none"
kwriteconfig6 --file kdeglobals --group General --key fixed "JetBrains Mono,10,-1,5,700,0,0,0,0,0,0,0,0,0,0,1,Bold"
kwriteconfig6 --file kdeglobals --group General --key font "JetBrains Mono,10,-1,5,700,0,0,0,0,0,0,0,0,0,0,1,Bold"
kwriteconfig6 --file kdeglobals --group General --key menuFont "JetBrains Mono,10,-1,5,700,0,0,0,0,0,0,0,0,0,0,1,Bold"
kwriteconfig6 --file kdeglobals --group General --key smallestReadableFont "JetBrains Mono,8,-1,5,700,0,0,0,0,0,0,0,0,0,0,1,Bold"
kwriteconfig6 --file kdeglobals --group General --key toolBarFont "JetBrains Mono,10,-1,5,700,0,0,0,0,0,0,0,0,0,0,1,Bold"

## GTK config ##
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-size 30
gsettings set org.gnome.desktop.interface font-antialiasing 'grayscale'
gsettings set org.gnome.desktop.interface font-hinting 'full'
gsettings set org.gnome.desktop.interface font-name 'JetBrains Mono Bold 10'
gsettings set org.gnome.desktop.interface font-rgba-order 'rgb'
gsettings set org.gnome.desktop.interface text-scaling-factor 1.0
gsettings set org.gnome.desktop.interface toolbar-icons-size 'large'
gsettings set org.gnome.desktop.interface toolbar-style 'both-horiz'
gsettings set org.gnome.desktop.sound event-sounds true
gsettings set org.gnome.desktop.sound input-feedback-sounds false

# GTK 3.0
crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-font-name JetBrains Mono Bold 10
crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-cursor-theme-size 30
crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-toolbar-style GTK_TOOLBAR_ICONS
crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-toolbar-icon-size GTK_ICON_SIZE_LARGE_TOOLBAR
crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-button-images 0
crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-menu-images 0
crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-enable-event-sounds 1
crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-enable-input-feedback-sounds 0
crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-xft-antialias 1
crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-xft-hinting 1
crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-xft-hintstyle hintfull
crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-xft-rgba rgb
crudini --set ~/.config/gtk-3.0/settings.ini Settings gtk-application-prefer-dark-theme 1

# GTK 4.0
crudini --set ~/.config/gtk-4.0/settings.ini Settings gtk-font-name JetBrains Mono Bold 10
crudini --set ~/.config/gtk-4.0/settings.ini Settings gtk-cursor-theme-size 30
crudini --set ~/.config/gtk-4.0/settings.ini Settings gtk-application-prefer-dark-theme 1
