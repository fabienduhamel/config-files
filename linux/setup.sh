#!/bin/bash

# this scripts runs the very essential commands for a new linux installation

# main packages
sudo apt install terminator zsh vim git dconf-tools htop iotop curl php npm nodejs

sudo ln -s /usr/bin/nodejs /usr/bin/node

# oh my zsh
wget --no-check-certificate http://install.ohmyz.sh -O - | sh

# zsh-git-prompt - See .zshrc for informations
git clone https://github.com/olivierverdier/zsh-git-prompt $ZSH_CUSTOM/plugins/zsh-git-prompt

# default shell
chsh -s /bin/zsh

# write '`' in a single tap
echo "keycode 16 = egrave 7 egrave 7 grave Egrave grave" >> ~/.xmodmap.conf

# diff-so-fancy (https://github.com/stevemao/diff-so-fancy)
sudo npm install -g diff-so-fancy

# composer.phar
su -c "curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer"

# developing font
sudo apt-get install fonts-inconsolata

# Atom settings
# http://atom.io/packages/sync-settings
# Managed by a personal gist :)

# Swapfile
sudo dd if=/dev/zero of=/swapfile bs=1M count=8192
sudo mkswap /swapfile
sudo chmod 600 /swapfile
sudo swapon /swapfile
su -c "echo '/swapfile     swap    swap    defaults    0   0' >> /etc/fstab"
su -c "echo 'vm.swappiness = 10' >> /etc/sysctl.conf"

# Change mdm keyboard layout
# Insert "/usr/bin/setxkbmap fr" before "exit 0" in /etc/mdm/Init/Default
su -c "sed -i 's#exit 0#/usr/bin/setxkbmap fr\nexit 0#g' /etc/mdm/Init/Default"

# OPTIONAL

# # vim bundles
# # @see https://github.com/VundleVim/Vundle.vim
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# # git-standup (https://github.com/kamranahmedse/git-standup)
# git clone https://github.com/kamranahmedse/git-standup.git
# cd git-standup
# sudo make install

# # php-pear
# sudo apt-get install php-pear

# # phpcs
# sudo pear install PHP_CodeSniffer

# # phpmd
# sudo pear channel-discover 'pear.phpmd.org'
# sudo pear channel-discover 'pear.pdepend.org'
# sudo pear install --alldeps 'phpmd/PHP_PMD'

# # Symfony2 coding standards
# cd /usr/share/php/PHP/CodeSniffer/Standards
# sudo git clone https://github.com/escapestudios/Symfony2-coding-standard.git Symfony2
