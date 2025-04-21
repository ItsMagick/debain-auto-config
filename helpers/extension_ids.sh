#!/bin/bash

OUTFILE="group_vars/all.yml"

# Check for jq
if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed. Install it with 'sudo apt install jq'."
    exit 1
fi

# Prepare YAML file
mkdir -p group_vars
echo "gnome_extensions:" > "$OUTFILE"

# Get enabled GNOME Shell extension UUIDs
uuids=$(gsettings get org.gnome.shell enabled-extensions | tr -d "[],'")

echo "Fetching GNOME Shell extension IDs..."

for uuid in $uuids; do
    uuid=$(echo "$uuid" | xargs)

   # Fetch metadata from GNOME extensions site
    response=$(curl -s "https://extensions.gnome.org/ajax/detail/?uuid=$uuid")

    id=$(echo "$response" | jq -r '.pk // empty')

    if [[ -n "$id" ]]; then
        echo "  - $id" >> "$OUTFILE"
        echo "$uuid: Extension ID = $id"
    else
        echo "$uuid: Not found or no ID"
    fi
done
echo "Saved extension IDs to $OUTFILE"

