#! /bin/bash
brew install openssl libuv cmake zlib
git clone https://github.com/uWebSockets/uWebSockets 
cd uWebSockets
git checkout e94b6e1
patch CMakeLists.txt < ../cmakepatch.txt
mkdir build
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig 
cd build
OPENSSL_VERSION=`openssl version -v | cut -d' ' -f2`
cmake -DOPENSSL_ROOT_DIR=$(brew --cellar openssl)/$OPENSSL_VERSION -DOPENSSL_LIBRARIES=$(brew --cellar openssl)/$OPENSSL_VERSION/lib ..
make 
sudo make install
cd ..
cd ..
sudo rm -r uWebSockets

# Solve problem: Cannot install/find OpenSSL
# 1. Find the path to OpenSSL locally. For me its: /usr/local/Cellar/openssl/1.0.2p. Make sure you can see hidden files.
cmake -DOPENSSL_ROOT_DIR=/usr/local/Cellar/openssl/1.0.2p -DOPENSSL_LIBRARIES=/usr/local/Cellar/openssl/1.0.2p/lib ..

#Solve warning:ld: warning: directory not found for option '-L/usr/local/Cellar/libuv/1*/lib'
sudo mkdir -p /opt/local/lib -p
