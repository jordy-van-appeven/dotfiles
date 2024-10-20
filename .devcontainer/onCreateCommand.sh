#!/bin/sh
sudo apt update
sudo apt install -y build-essential \
    ca-certificates \
    curl \
    git \
    gpg \
    openssh-client \
    wget \

# Add Kitware APT repository (https://apt.kitware.com/)
test -f /usr/share/doc/kitware-archive-keyring/copyright \
    || wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | \
        gpg --dearmor - | \
        sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null

echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ focal main' | \
    sudo tee /etc/apt/sources.list.d/kitware.list >/dev/null

sudo apt-get update
sudo apt-get install kitware-archive-keyring
sudo apt install -y cmake
