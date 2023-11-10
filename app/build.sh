#!/bin/bash
# Build the app
# Build from container by default
# Argument 'host' allow to build from host

# Strict mode
set -o errexit -o nounset -o pipefail
IFS=$'\n\t'

# Go to the script folder
cd "$(dirname "$0")"

# Get the app environment variables
source .env

# Get conan home
if [ -v OS_ENV ]
then
	CONAN_HOME="${PWD}/${CONAN_PATH}"
else
	CONAN_HOME=$(conan config home)
fi

# Get conan ctl
DROGON_CTL="$(find "${CONAN_HOME}" -path '*/bin/drogon_ctl')"

# Remove previous build
rm -rf build

# Configure and build app
cmake -S . -B build -G Ninja -D CMAKE_BUILD_TYPE=${BUILD_TYPE} -D CONAN_HOME=${CONAN_HOME} -D DROGON_CTL=${DROGON_CTL}
cmake --build build