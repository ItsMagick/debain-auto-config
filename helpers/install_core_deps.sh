#!/bin/bash

# This script installs the core dependencies for the project.

# --- Install python vitals
echo "This script will install the core dependencies for the project.\n"
echo "Installing python vitals...\n"
sudo apt install python3-pip python3-venv -y

# --- Install python dependencies
# Create a virtual environment
echo "Creating a virtual environment and activate it...\n"
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Install ansible and ansible-lint
echo "Installing ansible and ansible-lint...\n"
pip install ansible ansible-lint

# Install ansible flatpak module
echo "Installing ansible community for flatpak module...\n"
pip install ansible-galaxy collection install community.general

# Install the required packages
echo "Installing the required packages...\n"
sudo apt install python3-dev git curl wget openssh-server -y



