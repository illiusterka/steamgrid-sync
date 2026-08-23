#!/usr/bin/env bash

set -euo pipefail


INSTALL_DIR="$HOME/.local/bin"
INSTALL_PATH="$INSTALL_DIR/steamgrid-sync"

APPLICATIONS_DIR="$HOME/.local/share/applications"
DESKTOP_FILE="$APPLICATIONS_DIR/steamgrid-sync.desktop"

SOURCE_URL="https://raw.githubusercontent.com/illiusterka/steamgrid-sync/main/steamgrid-sync"


echo "Installing SteamGrid Sync..."
echo


mkdir -p "$INSTALL_DIR"

curl -fsSL "$SOURCE_URL" -o "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"


echo "Installed:"
echo "  $INSTALL_PATH"
echo


read -rp "Create an application launcher? [Y/n] " answer

if [[ ! "$answer" =~ ^[Nn]$ ]]; then
	mkdir -p "$APPLICATIONS_DIR"

	cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Type=Application
Name=SteamGrid Sync
Comment=Backup and restore SteamGrid artwork
Exec=konsole --title "SteamGrid Sync" -e "$INSTALL_PATH"
Icon=steam
Terminal=false
Categories=Utility;
EOF

	echo
	echo "Launcher created:"
	echo "  $DESKTOP_FILE"
fi


echo
echo "Starting SteamGrid Sync..."
echo

"$INSTALL_PATH" </dev/tty
