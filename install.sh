#!/bin/bash
set -e
DEB_URL="https://github.com/azarsoft/qrcraftrel/releases/latest/download/qrcraft_0.1.0_amd64.deb"
TEMP_DEB="$(mktemp)"

echo "Downloading QRCraft..."
wget -qO "$TEMP_DEB" "$DEB_URL"

echo "Installing QRCraft..."
sudo dpkg -i "$TEMP_DEB" || {
    echo "Resolving dependencies..."
    sudo apt-get install -f -y
}

rm -f "$TEMP_DEB"
echo "QRCraft installed successfully!"
