#!/bin/bash

# kde config
cp -r ./Themes/configuration/kde/* $HOME/.config/

# gtk 3/4 config
cp -r ./Themes/configuration/gtk-3-4/.config/* $HOME/.config/
cp -r ./Themes/configuration/gtk-3-4/.icons ./Themes/configuration/gtk-3-4/.gtkrc-2.0 $HOME/

ln -sf /usr/share/themes/Nordic-bluish-accent-v40/assets $HOME/.config/
ln -sf /usr/share/themes/Nordic-bluish-accent-v40/gtk-4.0/* $HOME/.config/gtk-4.0/
