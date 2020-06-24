#!/bin/bash

# Install salt-master
wget -O - https://repo.saltstack.com/py3/ubuntu/$(lsb_release -rs)/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/saltstack.list
deb http://repo.saltstack.com/py3/ubuntu/$(lsb_release -rs)/amd64/latest $(lsb_release -cs) main
EOF
sudo apt-get update
sudo apt-get install salt-master

cd saltstack
sudo cp etc/master /etc/salt/master
sudo cp -r salt /srv/
sudo cp -r pillar /srv/
sudo service salt-master start

# copy minion key files
sudo mkdir -p /etc/salt/pki/master/minions
cd keys
sudo bash -c 'find -type f -name "*.pub" | while read f; do cp "$f" "/etc/salt/pki/master/minions/${f%.pub}"; done'

# Install virtualbox
sudo apt-get install virtualbox

# Install Vagrant
sudo apt-get install unzip
wget https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_linux_amd64.zip
unzip vagrant_2.2.9_linux_amd64.zip
sudo mv vagrant /usr/local/bin/
rm -f vagrant_2.2.9_linux_amd64.zip