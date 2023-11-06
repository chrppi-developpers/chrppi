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

	# Install drogon_ctl (https://drogonframework.github.io/drogon-docs/#/ENG-02-Installation?id=ubuntu-1804)
	# Only build CTL (https://github.com/drogonframework/drogon#building-options)
	sudo apt-get install --yes \
		libjsoncpp-dev \
		uuid-dev \
		libssl-dev
	git clone --branch v1.9.0 --depth 1 https://github.com/drogonframework/drogon
	pushd drogon
	git submodule update --init
	cmake \
		-D CMAKE_BUILD_TYPE=Release \
		-D BUILD_EXAMPLES=OFF \
		-D BUILD_ORM=OFF \
		-D BUILD_BROTLI=OFF \
		-D BUILD_YAML_CONFIG=OFF \
		-S . \
		-B build \
		-G Ninja
	cmake --build build
	popd

	# Build Cling
	# Based on https://rawcdn.githack.com/root-project/cling/d59d27ad61f2f3a78cd46e652cd9fb8adb893565/www/build.html
	# With fix: https://reviews.llvm.org/D89450
	mkdir cling
	git clone --branch cling-v0.9 --depth 1 http://root.cern/git/llvm.git cling
	pushd cling/tools
	git clone --branch cling-v0.9 --depth 1 http://root.cern/git/clang.git
	git clone --branch v0.9 --depth 1 http://root.cern/git/cling.git
	cd ..
	sed --in-place '4i#include <limits>' utils/benchmark/src/benchmark_register.h
	cmake -S . -B build -G Ninja -D CMAKE_BUILD_TYPE=Release -D LLVM_BUILD_TOOLS=On
	cmake --build build --parallel $((1|$(nproc)/2))
	popd

	# Build chrpp
	git clone --branch v1.6.0 --depth 1 https://gitlab.com/vynce/chrpp.git
	pushd chrpp
	cmake -S . -B build -G Ninja -D CMAKE_BUILD_TYPE=Release -D EXAMPLES=OFF
	cmake --build build
	popd
	
	popd
fi

# Install third-parties
cd third-party
pushd drogon
	sudo cmake --install build
popd
pushd cling
	sudo cmake --install build
popd
pushd chrpp
	sudo cmake --install build