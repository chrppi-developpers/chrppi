#!/bin/bash
# Clean repository and keep build folders

# Strict mode
set -o errexit -o nounset -o pipefail
IFS=$'\n\t'

# Go to the project folder
cd "$(dirname "$0")/.."

# Equivalent to `git clean -ffdx` without removing large build folders 
sudo git ls-files --other --directory --exclude-standard \
	| grep --invert-match --extended-regexp "^app/conan/home/" \
	| grep --invert-match --extended-regexp "^app/third-party/" \
	| xargs -I{} rm --recursive --force {}