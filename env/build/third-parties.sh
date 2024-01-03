#!/bin/bash
# Get app third-parties

# Strict mode and trace
set -o errexit -o nounset -o pipefail
IFS=$'\n\t'

# Go to app directory
cd /media/user/app

# Download, configure and build third-parties used by the app
if [ ! -d third-party ]
then
	mkdir third-party
	pushd third-party
	sudo apt-get install --yes git

	# Build LLVM and Cling
	# Based on https://rawcdn.githack.com/root-project/cling/d59d27ad61f2f3a78cd46e652cd9fb8adb893565/www/build.html
	# With fix: https://reviews.llvm.org/D89450
	mkdir llvm
	pushd llvm
	git clone --branch cling-v0.9 --depth 1 http://root.cern/git/llvm.git source
	pushd source/tools
	git clone --branch cling-v0.9 --depth 1 http://root.cern/git/clang.git
	git clone --branch v0.9 --depth 1 http://root.cern/git/cling.git
	popd
	sed --in-place '4i#include <limits>' source/utils/benchmark/src/benchmark_register.h
	cmake -S source -B build -G Ninja -D CMAKE_BUILD_TYPE=Release -D LLVM_BUILD_TOOLS=On
	cmake --build build --parallel $((1|$(nproc)/2))
	popd

	# Build chrpp
	mkdir chrpp
	pushd chrpp
	git clone --branch v1.6.0 --depth 1 https://gitlab.com/vynce/chrpp.git source
	cmake -S source -B build -G Ninja -D CMAKE_BUILD_TYPE=Release -D EXAMPLES=OFF
	cmake --build build
	popd

	popd
fi

# Install third-parties
cd third-party
sudo cmake --install llvm/build
sudo cmake --install chrpp/build

# Fix Cling install (to build chrppi with CMake)
sudo cp llvm/build/lib/cmake/cling/ClingTargets.cmake /usr/local/lib/cmake/cling