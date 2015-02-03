#!/bin/bash

# this scripts runs the very essential commands for a new linux installation

# main packages
sudo apt-get install terminator zsh vim

# oh my zsh
wget --no-check-certificate http://install.ohmyz.sh -O - | sh

# default shell
chsh -s /bin/zsh

# php-pear
sudo apt-get install php-pear

# phpcs
sudo pear install PHP_CodeSniffer

# phpmd
sudo pear channel-discover 'pear.phpmd.org'
sudo pear channel-discover 'pear.pdepend.org'
sudo pear install --alldeps 'phpmd/PHP_PMD'

# # Symfony2 coding standards
# cd /usr/share/php/PHP/CodeSniffer/Standards
# sudo git clone https://github.com/escapestudios/Symfony2-coding-standard.git Symfony2
