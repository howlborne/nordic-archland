#!/usr/bin/env bash

echo "Building hyprshutdown with better UI..."

# hyprshutdown build with better UI
git clone https://github.com/hyprwm/hyprshutdown.git

cd hyprshutdown
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
sleep 1
make
sleep 1
sudo make install
cd ../..
rm -rf hyprshutdown

echo "Done!"
