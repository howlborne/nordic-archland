#!/bin/bash

file="$HOME/.config/mimeapps.list"
entry="inode/directory=org.kde.dolphin.desktop"

grep -qxF "$entry" "$file" 2>/dev/null || \
sed -i "/^\[Default Applications\]/a $entry" "$file"
