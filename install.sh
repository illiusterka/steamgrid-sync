#!/usr/bin/env bash

set -euo pipefail

INSTALL_DIR="$HOME/.local/bin"
INSTALL_PATH="$INSTALL_DIR/steamgrid-sync"
SOURCE_URL="https://raw.githubusercontent.com/illiusterka/steamgrid-sync/main/steamgrid-sync"
APPLICATIONS_DIR="$HOME/.local/share/applications"
DESKTOP_FILE="$APPLICATIONS_DIR/steamgrid-sync.desktop"

mkdir -p "$INSTALL_DIR"
echo "Installing SteamGrid Sync..."
curl -fsSL "$SOURCE_URL" -o "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"
echo
echo "Installed:"
echo "  $INSTALL_PATH"
echo


create_launcher() {
	mkdir -p "$APPLICATIONS_DIR"
	local script_path
	script_path="$(realpath "$0")"
	cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Type=Application
Name=SteamGrid Sync
Comment=Backup and restore SteamGrid artwork
Exec=konsole --title "SteamGrid Sync" -e "$script_path"
Icon=steam
Terminal=false
Categories=Utility;
EOF
}

read -rp "Create an application launcher? [Y/n] " answer
if [[ ! "$answer" =~ ^[Nn]$ ]]; then
    create_launcher
    echo
    echo "Launcher created:"
    echo " $DESKTOP_FILE"
fi
"$INSTALL_PATH" </dev/tty


