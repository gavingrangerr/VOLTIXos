#!/bin/bash
# Voltix OS - Buildroot build script
# Builds a complete Voltix OS image for Raspberry Pi 5 from scratch.
#
# Requirements: Linux (Ubuntu/Debian) with build dependencies:
#   sudo apt install -y build-essential libncurses-dev git wget unzip \
#     rsync python3 bc file
#
# Usage: ./build.sh [clean]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
BUILDROOT_VERSION="2024.11.1"
BUILDROOT_URL="https://buildroot.org/downloads/buildroot-${BUILDROOT_VERSION}.tar.xz"
BUILD_DIR="${PROJECT_ROOT}/build"
BR_DIR="${BUILD_DIR}/buildroot-${BUILDROOT_VERSION}"
OUTPUT_DIR="${BUILD_DIR}/output"

case "${1:-}" in
  clean)
    echo "Cleaning build directory..."
    rm -rf "${BUILD_DIR}"
    echo "Done."
    exit 0
    ;;
esac

echo "=== Voltix OS Buildroot Builder ==="
echo "Project root: ${PROJECT_ROOT}"
echo "Build dir:    ${BUILD_DIR}"
echo ""

# Create build directory
mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

# Download Buildroot if needed
if [ ! -d "${BR_DIR}" ]; then
  echo "[1/4] Downloading Buildroot ${BUILDROOT_VERSION}..."
  wget -q --show-progress -O buildroot.tar.xz "${BUILDROOT_URL}"
  tar xf buildroot.tar.xz
  rm buildroot.tar.xz
  echo "      Done."
else
  echo "[1/4] Buildroot already present."
fi

# Configure
echo "[2/4] Configuring Voltix OS (voltix_rpi5_defconfig)..."
cd "${BR_DIR}"
make O="${OUTPUT_DIR}" BR2_EXTERNAL="${PROJECT_ROOT}/buildroot" voltix_rpi5_defconfig

# Build
echo "[3/4] Building (this takes 1-2 hours on first run)..."
make O="${OUTPUT_DIR}"

# Summary
echo ""
echo "[4/4] Build complete!"
echo ""
echo "Image: ${OUTPUT_DIR}/images/sdcard.img"
echo ""
echo "Flash to SD card:"
echo "  sudo dd if=${OUTPUT_DIR}/images/sdcard.img of=/dev/sdX bs=4M status=progress conv=fsync"
echo ""
echo "Default login: root (no password - set one with 'passwd' on first boot)"
