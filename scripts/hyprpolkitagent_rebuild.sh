#!/usr/bin/env bash

echo "Building hyprpolkitagent with better UI..."

# hyprpolkitagent build with better UI
git clone https://github.com/hyprwm/hyprpolkitagent.git
cp ../hyprpolkitagent-qml/main.qml ./hyprpolkitagent/qml/
cd hyprpolkitagent
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
sleep 1
make
sleep 1
sudo make install
cd ../..
rm -rf hyprpolkitagent

echo "Done!"
