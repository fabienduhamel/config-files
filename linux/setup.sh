#!/bin/bash

# this scripts runs the very essential commands for a new linux installation

# main packages
sudo apt install terminator zsh vim git dconf-tools htop iotop curl php5-cli php5-curl

# oh my zsh
wget --no-check-certificate http://install.ohmyz.sh -O - | sh

# zsh-git-prompt - See .zshrc for informations
cd $ZSH/custom/plugins
git clone https://github.com/olivierverdier/zsh-git-prompt
cd

# default shell
chsh -s /bin/zsh

# git-standup (https://github.com/kamranahmedse/git-standup)
git clone https://github.com/kamranahmedse/git-standup.git
cd git-standup
sudo make install

# diff-so-fancy (https://github.com/stevemao/diff-so-fancy)
sudo npm install -g diff-so-fancy

# Monaco font
# https://github.com/cstrap/monaco-font
curl -kL https://raw.github.com/cstrap/monaco-font/master/install-font-ubuntu.sh | bash

# bower
sudo apt-get install npm nodejs
sudo npm install -g bower
# if bower doesnt find node:
sudo ln -s /usr/bin/nodejs /usr/bin/node

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

# developing font
sudo apt-get install fonts-inconsolata

# vim bundles
# @see https://github.com/VundleVim/Vundle.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Atom settings
# http://atom.io/packages/sync-settings
# Managed by a personal gist :)

# Symfony2 coding standards
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
