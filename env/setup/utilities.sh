#!/bin/bash
# Install utilities

# Diplay commands and end script at first command fail or use of an unset variable
set -o errexit -o nounset -o xtrace -o pipefail

# Go to the app home
cd /home/app

# Set Bash promt and aliases
cat /tmp/setup/include/utilities/prompt.sh >> .bashrc
cp /tmp/setup/include/utilities/aliases.sh .bash_aliases

# Add bin folder to path
echo 'export PATH=$PATH:/home/app/bin' >> .bashrc

# Install utilities
sudo apt-get install --yes vim
sudo apt-get install --yes man
