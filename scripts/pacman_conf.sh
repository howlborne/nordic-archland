#!/bin/bash

sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key F3B607488DB35A47

sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-22-1-any.pkg.tar.zst' \
'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-22-1-any.pkg.tar.zst'

PACMANCONF="/etc/pacman.conf"
BACKUP="$PACMANCONF.backup.$(date +%Y%m%d_%H%M%S)"

# Create backup
cp "$PACMANCONF" "$BACKUP"
echo "Backup created at: $BACKUP"

# Only add if not already set
if ! grep -q "^Color" "$PACMANCONF"; then
    # Use sed to insert after [options] section
    sed -i '/^# Misc options/{
        a Color
    }' "$PACMANCONF"
fi

# Only add if not already set
if ! grep -q "^ILoveCandy" "$PACMANCONF"; then
    # Use sed to insert after [options] section
    sed -i '/^# Misc options/{
        a ILoveCandy
    }' "$PACMANCONF"
fi

# Add x86_64_v3 architecture if not already present
if grep -q "^Architecture = auto$" "$PACMANCONF" && \
   ! grep -q "^Architecture = auto x86_64_v3$" "$PACMANCONF"; then
    sed -i 's/^Architecture = auto$/Architecture = auto x86_64_v3/' "$PACMANCONF"
fi

# Add CachyOS repositories before core-testing if missing
if ! grep -q '^\[cachyos-v3\]' "$PACMANCONF"; then
    sed -i '/^#\[core-testing\]/i \
# CachyOS repos\
[cachyos-v3]\
Include = /etc/pacman.d/cachyos-v3-mirrorlist\
[cachyos-core-v3]\
Include = /etc/pacman.d/cachyos-v3-mirrorlist\
[cachyos-extra-v3]\
Include = /etc/pacman.d/cachyos-v3-mirrorlist\
\
# Arch repos\
' "$PACMANCONF"
fi
