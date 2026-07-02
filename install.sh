#!/bin/bash
set -e


echo "Fetching latest release information..."
DEB_URL=$(curl -s https://api.github.com/repos/azarsoft/qrcraftrel/releases/latest | grep "browser_download_url.*deb" | cut -d '"' -f 4)

if [ -z "$DEB_URL" ]; then
    echo "Error: Could not find any .deb package in the latest release."
    exit 1
fi

TEMP_DEB="$(mktemp)"

echo "Downloading QRCraft from $DEB_URL..."
wget -qO "$TEMP_DEB" "$DEB_URL"

echo "Installing QRCraft..."
sudo dpkg -i "$TEMP_DEB" || {
    echo "Resolving dependencies..."
    sudo apt-get install -f -y
}

rm -f "$TEMP_DEB"
echo "QRCraft installed successfully!"
