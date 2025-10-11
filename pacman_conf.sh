#!/bin/bash

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
