#!/bin/bash

sudo apt-get update
# Install Necessary Tools:
sudo apt install vim fish python3-pip silversearcher-ag

# Load vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Oh F@%$
pip3 install thefuck

# Install FZF (configured in fish ctrl+r & ctrl+t):
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Build current TMUX
sudo apt install automake build-essential pkg-config libevent-dev libncurses5-dev bison
git clone https://github.com/tmux/tmux.git ~/dotfiles/tmux
cd ~/dotfiles/tmux
git checkout tags/2.9a
./autogen.sh; ./configure; make
sudo make install
sudo apt remove automake build-essential pkg-config libevent-dev libncurses5-dev bison
cd ~/dotfiles
rm -rf tmux

# Setup TERM:
tic -x ./tmux-256color.terminfo

# Setup Git:
git config --global user.name "oncomouse"
git config --global user.email "oncomouse@gmail.com"

# Setup Firewall:
sudo ufw allow OpenSSH
sudo ufw enable

# install fail2ban:
sudo apt-get install fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# IP Sec features:
echo "Copy your SSH key(s) and turn off Root/Password login. Add IP Hardening"
echo "\n\thttps://dennisnotes.com/note/20180627-ubuntu-18.04-server-setup/\n"

# Restrict su
sudo groupadd admin
sudo usermod -a -G admin andrew
sudo dpkg-statoverride --update --add root admin 4750 /bin/su
