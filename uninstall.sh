#!/usr/bin/env bash

set -euo pipefail


INSTALL_PATH="$HOME/.local/bin/steamgrid-sync"
DESKTOP_FILE="$HOME/.local/share/applications/steamgrid-sync.desktop"


echo "Uninstalling SteamGrid Sync..."
echo


echo "The following will be removed:"
echo "  $INSTALL_PATH"
echo "  $DESKTOP_FILE"
echo
echo "Your configuration and backups will not be touched."
echo


read -rp "Continue? [y/N] " answer </dev/tty

if [[ ! "$answer" =~ ^[Yy]$ ]]; then
	echo
	echo "Aborted."
	exit 0
fi


rm -f "$INSTALL_PATH"
rm -f "$DESKTOP_FILE"


echo
echo "SteamGrid Sync has been uninstalled."
