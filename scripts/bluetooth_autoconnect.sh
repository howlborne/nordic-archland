#!/usr/bin/env bash

BT_MAIN="/etc/bluetooth/main.conf"
BACKUP="$BT_MAIN.backup.$(date +%Y%m%d_%H%M%S)"

# Create backup
cp "$BT_MAIN" "$BACKUP"
echo "Backup created at: $BACKUP"

# Only add if not already set
if ! grep -q "^AutoConnect=true" "$BT_MAIN"; then
    # Use sed to insert after [General] section
    sed -i '/^\[General\]/{
        a AutoConnect=true
    }' "$BT_MAIN"
fi

if ! grep -q "^AutoEnable=true" "$BT_MAIN"; then
    # Use sed to insert after [Policy] section
    sed -i '/^\[Policy\]/{
        a AutoEnable=true
    }' "$BT_MAIN"
fi
