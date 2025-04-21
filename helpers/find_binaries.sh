#!/bin/bash

echo "Directories where custom binaries are often installed"
custom_dirs=("/usr/local/bin" "/opt" "/home/$(whoami)/bin")

# Find all executables in those directories
custom_binaries=$(find "${custom_dirs[@]}" -type f -executable)

echo "Custom binaries that are not installed via APT:"

# Loop through each binary and check if it is installed via APT or not
for bin in $custom_binaries; do
    # Check if the binary belongs to any APT package
    if ! dpkg -S $bin &>/dev/null; then
        echo "Custom Binary: $bin"
    fi
done
echo "--------------------------------------------------------------------------"
echo "Installed packages with APT"
# Get the list of manually installed packages
manual_packages=$(apt-mark showmanual)

# Loop through each package and list binaries
echo "Binaries installed by manually installed packages:"
for package in $manual_packages; do
    # List files installed by each package and filter for binaries
    dpkg-query -L $package | grep '/bin\|/sbin\|/usr/bin\|/usr/sbin'
done

