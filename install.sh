#!/usr/bin/env bash

set -euo pipefail


INSTALL_DIR="$HOME/.local/bin"
INSTALL_PATH="$INSTALL_DIR/steamgrid-sync"

APPLICATIONS_DIR="$HOME/.local/share/applications"
DESKTOP_FILE="$APPLICATIONS_DIR/steamgrid-sync.desktop"

SOURCE_URL="https://raw.githubusercontent.com/illiusterka/steamgrid-sync/main/steamgrid-sync"


detect_terminal() {
	if command -v konsole >/dev/null 2>&1; then
		printf 'konsole --title "SteamGrid Sync" -e %s' "$INSTALL_PATH"
	elif command -v gnome-terminal >/dev/null 2>&1; then
		printf 'gnome-terminal -- %s' "$INSTALL_PATH"
	elif command -v xfce4-terminal >/dev/null 2>&1; then
		printf 'xfce4-terminal --command=%s' "$INSTALL_PATH"
	elif command -v xterm >/dev/null 2>&1; then
		printf 'xterm -e %s' "$INSTALL_PATH"
	else
		return 1
	fi
}


echo "Installing SteamGrid Sync..."
echo


mkdir -p "$INSTALL_DIR"

curl -fsSL "$SOURCE_URL" -o "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"


echo "Installed:"
echo "  $INSTALL_PATH"
echo


read -rp "Create an application launcher? [Y/n] " answer </dev/tty

if [[ ! "$answer" =~ ^[Nn]$ ]]; then
	TERMINAL_EXEC="$(detect_terminal)" || {
		echo
		echo "Could not find a supported terminal emulator."
		echo "Launcher was not created."
		TERMINAL_EXEC=''
	}

	if [[ -n "$TERMINAL_EXEC" ]]; then
		mkdir -p "$APPLICATIONS_DIR"

		echo "[Desktop Entry]" > "$DESKTOP_FILE"
		echo "Type=Application" >> "$DESKTOP_FILE"
		echo "Name=SteamGrid Sync" >> "$DESKTOP_FILE"
		echo "Comment=Backup and restore SteamGrid artwork" >> "$DESKTOP_FILE"
		printf 'Exec=%s\n' "$TERMINAL_EXEC" >> "$DESKTOP_FILE"
		echo "Icon=steam" >> "$DESKTOP_FILE"
		echo "Terminal=false" >> "$DESKTOP_FILE"
		echo "Categories=Utility;" >> "$DESKTOP_FILE"

		echo
		echo "Launcher created:"
		echo "  $DESKTOP_FILE"
	fi
fi


echo
echo "Starting SteamGrid Sync..."
echo

"$INSTALL_PATH" </dev/tty
