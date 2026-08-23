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


read -rp "Create a KDE application launcher? [Y/n] " answer

if [[ ! "$answer" =~ ^[Nn]$ ]]; then
	mkdir -p "$APPLICATIONS_DIR"

	{
		echo "[Desktop Entry]"
		echo "Type=Application"
		echo "Name=SteamGrid Sync"
		echo "Comment=Backup and restore SteamGrid artwork"
		printf 'Exec=konsole --title "SteamGrid Sync" -e %s\n' "$INSTALL_PATH"
		echo "Icon=steam"
		echo "Terminal=false"
		echo "Categories=Utility;"
	} > "$DESKTOP_FILE"

	echo
	echo "Launcher created:"
	echo "  $DESKTOP_FILE"
fi


echo
echo "Starting SteamGrid Sync..."
echo

"$INSTALL_PATH" </dev/tty
