#!/bin/bash
# Install required packages

# Diplay commands and end script at first command fail or use of an unset variable
set -o errexit -o nounset -o xtrace -o pipefail

# Install Conan (https://docs.conan.io/2/installation.html)
apt-get install python3-pip=23.0.1+dfsg-1 --yes
pip install --break-system-packages conan
apt-get install cmake=3.25.1-1 --yes
sudo --user app conan profile detect

# Install drogon_ctl (https://drogonframework.github.io/drogon-docs/#/ENG-02-Installation?id=ubuntu-1804)
# Only build CTL (https://github.com/drogonframework/drogon#building-options)
apt-get install \
	git=1:2.39.2-1.1 \
	libjsoncpp-dev=1.9.5-4 \
	uuid-dev=2.38.1-5+b1 \
	libssl-dev=3.0.11-1~deb12u1 \
	--yes
git clone --branch v1.9.0-rc.1 https://github.com/drogonframework/drogon
cd drogon
git submodule update --init
mkdir build
cd build
cmake \
	-D CMAKE_BUILD_TYPE=Release \
	-D BUILD_EXAMPLES=OFF \
	-D BUILD_ORM=OFF \
	-D BUILD_BROTLI=OFF \
	-D BUILD_YAML_CONFIG=OFF \
	..
make --jobs $(nproc)
make install
cd ..
rm --recursive --force drogon