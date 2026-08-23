#!/usr/bin/env bash

set -euo pipefail

REPO="https://raw.githubusercontent.com/illiusterka/steamgrid-sync/main"
INSTALL_DIR="$HOME/.local/bin"
INSTALL_PATH="$INSTALL_DIR/steamgrid-sync"

echo "Installing SteamGrid Sync..."

mkdir -p "$INSTALL_DIR"

curl -fsSL "$REPO/steamgrid-sync" -o "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"

echo
echo "Installed:"
echo "  $INSTALL_PATH"
echo
echo "Run it with:"
echo "  steamgrid-sync"
