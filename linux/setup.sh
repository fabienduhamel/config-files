#!/bin/bash

# this scripts runs the very essential commands for my new linux installation(s)

# main packages
sudo apt-get install terminator zsh

# oh my zsh
wget --no-check-certificate http://install.ohmyz.sh -O - | sh

# default shell
chsh -s /bin/zsh

