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

# Set the right conan home
if [[ $# = 1 && $1 = host ]]
then
	CONAN_HOME=$(conan config home)
else
	CONAN_HOME="${PWD}/${CONAN_PATH}"
fi

# Remove previous build
rm -rf build

# Configure and build app
cmake -S . -B build -G Ninja -D CMAKE_BUILD_TYPE=${BUILD_TYPE} -D CONAN_HOME=${CONAN_HOME}
cmake --build build