#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
# Install Necessary Tools:
sudo apt -y install vim fish python3-pip silversearcher-ag

# Copy Configuration Files

cp -r ~/dotfiles/.vim* ~/
cp -r ~/dotfiles/.config ~/

# Load vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# Oh F@%$
pip3 install thefuck

# Install FZF (configured in fish ctrl+r & ctrl+t):
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Build current TMUX
sudo apt -y install automake build-essential pkg-config libevent-dev libncurses5-dev bison
git clone https://github.com/tmux/tmux.git ~/dotfiles/tmux
cd ~/dotfiles/tmux
git checkout tags/2.9a
./autogen.sh; ./configure; make
sudo make install
sudo apt -y remove automake build-essential pkg-config libevent-dev libncurses5-dev bison
cd ~/dotfiles
rm -rf tmux

# Configure TMUX
git clone https://github.com/gpakosz/.tmux ~/.tmux
ln -s -f .tmux/.tmux.conf
cp ~/dotfiles/.tmux.conf.local ~/

# Setup TERM:
tic -x ./tmux-256color.terminfo

# Setup Git:
git config --global user.name "oncomouse"
git config --global user.email "oncomouse@gmail.com"

# Setup Firewall:
sudo ufw allow OpenSSH
sudo ufw enable

# install fail2ban:
sudo apt-get -y install fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# IP Sec features:
echo "Copy your SSH key(s) and turn off Root/Password login. Add IP Hardening"
echo "\n\thttps://dennisnotes.com/note/20180627-ubuntu-18.04-server-setup/\n"

# Restrict su
sudo groupadd admin
sudo usermod -a -G admin andrew
sudo dpkg-statoverride --update --add root admin 4750 /bin/su
sudo passwd -l root

# Secure /tmp
sudo fallocate -l 1G /tmpdisk
sudo mkfs.ext4 /tmpdisk
sudo chmod 0600 /tmpdisk
sudo mount -o loop,noexec,nosuid,rw /tmpdisk /tmp
sudo chmod 1777 /tmp
sudo fish -c "echo \"/tmpdisk/tmp ext4 loop,nosuid,noexec,rw 0 0\" >> /etc/fstab"
sudo mv /var/tmp /var/tmpold
sudo ln -s /tmp /var/tmp
sudo cp -prf /var/tmpold/* /tmp/
sudo rm -rf /var/tmpold/
sudo fish -c "echo \"tmpfs /run/shm tmpfs ro,noexec,nosuid 0 0\" >> /etc/fstab"

# Clean up
sudo apt -y autoremove
