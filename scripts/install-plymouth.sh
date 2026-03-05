#!/bin/bash
# Install Voltix Plymouth boot splash theme

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
THEME_DIR="$PROJECT_ROOT/plymouth/voltix"

if [ ! -d "$THEME_DIR" ]; then
    echo "Theme directory not found: $THEME_DIR"
    exit 1
fi

# Install plymouth if not present
apt-get install -y plymouth plymouth-themes

# Copy theme to Plymouth directory
cp -r "$THEME_DIR" /usr/share/plymouth/themes/voltix

# Set as default
plymouth-set-default-theme -R voltix

echo "Plymouth theme 'voltix' installed. Reboot to see the new boot splash."
