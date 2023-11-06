#!/bin/bash
# Run the app

# Strict mode
set -o errexit -o nounset -o pipefail
IFS=$'\n\t'

# Go to the script folder
cd "$(dirname "$0")"

# Get the app environment variables
source .env

# Build and execute the app
./build.sh
./build/${APP_NAME} $INTERNAL_PORT