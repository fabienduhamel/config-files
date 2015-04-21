#!/bin/bash

# this scripts runs the very essential commands for a new linux installation

# main packages
sudo apt-get install terminator zsh vim dconf-tools htop

# oh my zsh
wget --no-check-certificate http://install.ohmyz.sh -O - | sh

# zsh-git-prompt - See .zshrc for informations
cd $ZSH/plugins
git clone https://github.com/olivierverdier/zsh-git-prompt
cd

# default shell
chsh -s /bin/zsh

# composer.phar
su -
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# php-pear
sudo apt-get install php-pear

# phpcs
sudo pear install PHP_CodeSniffer

# phpmd
sudo pear channel-discover 'pear.phpmd.org'
sudo pear channel-discover 'pear.pdepend.org'
sudo pear install --alldeps 'phpmd/PHP_PMD'

# # Symfony2 coding standards
cd /usr/share/php/PHP/CodeSniffer/Standards
sudo git clone https://github.com/escapestudios/Symfony2-coding-standard.git Symfony2

# Swapfile
dd if=/dev/zero of=/swapfile bs=1M count=8192
mkswap /swapfile
swapon /swapfile
# /etc/fstab
/swapfile     swap    swap    defaults    0   0
# /etc/sysctl.conf
echo "vm.swappiness = 10" >> /etc/sysctl.conf
