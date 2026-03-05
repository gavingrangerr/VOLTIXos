#!/bin/sh
# Voltix OS - Install code-server (VS Code in browser)
# Runs during Buildroot post-build, has access to TARGET_DIR

set -e

CODE_SERVER_VERSION="4.109.5"
CODE_SERVER_URL="https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server-${CODE_SERVER_VERSION}-linux-arm64.tar.gz"
INSTALL_DIR="${TARGET_DIR}/opt/code-server"

echo "Installing code-server ${CODE_SERVER_VERSION}..."

mkdir -p "${INSTALL_DIR}"
cd /tmp
wget -q --show-progress "${CODE_SERVER_URL}" -O code-server.tar.gz
tar xzf code-server.tar.gz
cp -a "code-server-${CODE_SERVER_VERSION}-linux-arm64"/* "${INSTALL_DIR}/"
rm -rf "code-server-${CODE_SERVER_VERSION}-linux-arm64" code-server.tar.gz

# Symlink for easy access
ln -sf /opt/code-server/bin/code-server "${TARGET_DIR}/usr/bin/code-server"

echo "code-server installed to /opt/code-server"
