#!/bin/bash
# Install required packages

# Strict mode and trace
set -o errexit -o nounset -o pipefail
IFS=$'\n\t'

# Go to app directory
cd /media/user/app

# Get the app environment variables
source .env

# Install Conan (https://docs.conan.io/2/installation.html)
sudo apt-get install python3-pip --yes
sudo pip install --break-system-packages conan
CONAN_HOME="${PWD}/${CONAN_PATH}"
if [ ! -f "${CONAN_HOME}/profiles/default" ]
then
	export CONAN_HOME
	conan profile detect
fi

# Install tools to build the app
sudo apt-get install --yes cmake ninja-build g++ python3