#!/bin/bash

sudo apt-get update
sudo apt-get install -y ca-certificates curl pv tmux gnupg lsb-release python3-pip

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get install -y docker-ce docker-ce-cli containerd.io

apt-cache madison docker-ce

sudo apt-get install -y docker-ce=5:20.10.12~3-0~ubuntu-focal docker-ce-cli=5:20.10.12~3-0~ubuntu-focal

git clone https://github.com/MHProDev/MHDDoS.git
cd MHDDoS
pip3 install -r requirements.txt




