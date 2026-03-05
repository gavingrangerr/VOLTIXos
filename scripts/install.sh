#!/bin/bash
# Voltix OS - Base installer
# Run on a fresh Raspberry Pi OS Lite: sudo ./install.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "[Voltix OS] Installing base system..."

# Check we're on Raspberry Pi OS
if [ ! -f /etc/os-release ]; then
    echo "Error: /etc/os-release not found. Are you on Raspberry Pi OS?"
    exit 1
fi

# 1. Update system
apt-get update
apt-get upgrade -y

# 2. Install packages (skip comments and empty lines)
if [ -f "$PROJECT_ROOT/packages.txt" ]; then
    echo "[Voltix OS] Installing packages..."
    grep -v '^#' "$PROJECT_ROOT/packages.txt" | grep -v '^$' | xargs apt-get install -y
fi

# 3. Set hostname
echo "voltix-os" > /etc/hostname
sed -i 's/127.0.1.1.*/127.0.1.1\tvoltix-os/' /etc/hosts 2>/dev/null || true

# 4. Install MOTD
if [ -f "$PROJECT_ROOT/etc/motd" ]; then
    cp "$PROJECT_ROOT/etc/motd" /etc/motd
    chmod 644 /etc/motd
    echo "[Voltix OS] MOTD installed"
fi

# 5. Merge custom bashrc (pi user on Raspberry Pi OS, or user who ran sudo)
if [ -n "$SUDO_USER" ]; then
    USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
else
    USER_HOME="/home/pi"
fi
[ ! -d "$USER_HOME" ] && USER_HOME="/home/pi"
USER_NAME=$(basename "$USER_HOME")
if [ -f "$USER_HOME/.bashrc" ] && [ -f "$PROJECT_ROOT/config/bashrc-voltix" ]; then
    if ! grep -q "Voltix OS" "$USER_HOME/.bashrc" 2>/dev/null; then
        echo "" >> "$USER_HOME/.bashrc"
        echo "# Voltix OS customizations" >> "$USER_HOME/.bashrc"
        cat "$PROJECT_ROOT/config/bashrc-voltix" >> "$USER_HOME/.bashrc"
        chown "$USER_NAME:$USER_NAME" "$USER_HOME/.bashrc" 2>/dev/null || true
        echo "[Voltix OS] Bash profile installed for $USER_NAME"
    fi
fi

# 6. Set green-on-black for TTY (optional)
if [ -f "$PROJECT_ROOT/config/setterm.conf" ]; then
    cp "$PROJECT_ROOT/config/setterm.conf" /etc/default/voltix-setterm 2>/dev/null || true
fi

# 7. Install Plymouth theme if available
if [ -d "$PROJECT_ROOT/plymouth/voltix" ]; then
    "$SCRIPT_DIR/install-plymouth.sh" 2>/dev/null || echo "[Voltix OS] Plymouth install skipped (may need manual setup)"
fi

echo ""
echo "[Voltix OS] Installation complete!"
echo "  - Hostname: voltix-os"
echo "  - Run 'voltix-info' after login for system info"
echo "  - Run 'matrix' for Matrix rain effect"
echo ""
echo "Reboot to apply all changes: sudo reboot"
