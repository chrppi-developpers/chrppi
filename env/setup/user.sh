#!/bin/bash
# Create the app user

# Diplay commands and end script at first command fail or use of an unset variable
set -o errexit -o nounset -o xtrace -o pipefail

# Set the correct timezone
ln --symbolic --force /usr/share/zoneinfo/Europe/Paris /etc/localtime

# Create app user
useradd app --uid $1 --create-home --shell /bin/bash
usermod --append --groups sudo app
passwd --delete app

# Update software repositories and install sudo
apt-get update
apt-get install --yes sudo