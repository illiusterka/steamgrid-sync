#!/usr/bin/env bash

set -euo pipefail

INSTALL_DIR="$HOME/.local/bin"
INSTALL_PATH="$INSTALL_DIR/steamgrid-sync"
SOURCE_URL="https://raw.githubusercontent.com/illiusterka/steamgrid-sync/main/steamgrid-sync"

mkdir -p "$INSTALL_DIR"

echo "Installing SteamGrid Sync..."

curl -fsSL "$SOURCE_URL" -o "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"

echo
echo "Installed:"
echo "  $INSTALL_PATH"
echo

"$INSTALL_PATH"
