#!/bin/bash

set -e

uuid="$1"
version=$(gnome-shell --version | grep -oP '\d+\.\d+' | head -1)

# Get download URL
metadata=$(curl -s "https://extensions.gnome.org/extension-info/?uuid=$uuid&shell_version=$version")
download_path=$(echo "$metadata" | jq -r '.download_url')
extension_name=$(echo "$metadata" | jq -r '.uuid')

if [[ "$download_path" == "null" ]]; then
  echo "Extension $uuid is not available for GNOME Shell $version"
  exit 1
fi

# Download and install
tmp_file=$(mktemp /tmp/gnome-extension-XXXX.zip)
curl -s "https://extensions.gnome.org$download_path" -o "$tmp_file"
gnome-extensions install --force "$tmp_file"
rm "$tmp_file"

echo "Installed: $extension_name"

