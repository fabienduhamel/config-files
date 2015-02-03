#!/bin/bash

# this scripts runs the very essential commands for a new linux installation

# main packages
sudo apt-get install terminator zsh vim

# oh my zsh
wget --no-check-certificate http://install.ohmyz.sh -O - | sh

# default shell
chsh -s /bin/zsh
