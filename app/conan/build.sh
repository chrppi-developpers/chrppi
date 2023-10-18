#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

cd "$(dirname "$0")"

conan install file.txt --output-folder=.. --build=missing --profile=profile.txt