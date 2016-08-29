#!/bin/bash

# Steam audio output switch issue with PulseAudio (remove DONT_MOVE flag for PulseAudio Steam sinks)
# see http://steamcommunity.com/app/93200/discussions/0/864959809826195633/?l=french
echo "[pulse]\nallow-moves=yes" > ~/.alsoftrc

# Wakeup from wireless logitech keyboard
git clone https://github.com/3v1n0/Solaar.git
cd Solaar/rules.d
./install.sh
cd

# Numix circle icon theme
sudo apt-add-repository ppa:numix/ppa
sudo apt-get update
sudo apt-get install numix-icon-theme numix-icon-theme-circle

# Truecrypt
sudo add-apt-repository ppa:stefansundin/truecrypt && sudo apt-get update && sudo apt-get install truecrypt

