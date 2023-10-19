#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Go to the backend root folder
cd "$(dirname "$0")"

./build.sh && ./build/chrppi