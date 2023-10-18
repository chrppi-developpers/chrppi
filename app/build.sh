#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Go to the backend root folder
cd "$(dirname "$0")"

# Get the app environment variables
source .env

rm -rf build
./conan/build.sh
cd build
cmake -D CMAKE_BUILD_TYPE=${BUILD_TYPE} ..
make