#!/bin/bash

KDEGLOBALS="$HOME/.config/kdeglobals"
BACKUP="$KDEGLOBALS.backup.$(date +%Y%m%d_%H%M%S)"

# Create backup
cp "$KDEGLOBALS" "$BACKUP"
echo "Backup created at: $BACKUP"

# Only add if not already set
if ! grep -q "^TerminalApplication=alacritty" "$KDEGLOBALS"; then
    # Use sed to insert after [General] section
    sed -i '/^\[General\]/{
        a TerminalApplication=alacritty
    }' "$KDEGLOBALS"
fi

# Only add if not already set
if ! grep -q "^ColorScheme=UtterlyNord" "$KDEGLOBALS"; then
    # Use sed to insert after [General] section
    sed -i '/^\[General\]/{
        a ColorScheme=UtterlyNord
    }' "$KDEGLOBALS"
fi

# Only add if not already set
if ! grep -q "^Theme=Nordzy-dark" "$KDEGLOBALS"; then
    # Use sed to insert after [General] section
    sed -i '/^\[Icons\]/{
        a Theme=Nordzy-dark
    }' "$KDEGLOBALS"
fi
