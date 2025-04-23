#!/bin/bash
set -ex

# Install core dependencies
echo "Installing core dependencies in helpers/install_core_dependencies.sh \n"
./helpers/install_core_dependencies.sh

# Let the fun begin... installing your setup
echo "Installing your setup in helpers/run_ansible.sh \n"
./helpers/run_ansible.sh

