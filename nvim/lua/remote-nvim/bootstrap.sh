#!/bin/sh

# Install packages
export DEBIAN_FRONTEND=noninteractive 
apt update && apt install --yes \
    ca-certificates \
    ccache \
    cmake \
    curl \
    git \
    gpg \
    git \
    nodejs \
    npm \
    openssh-client \
    python3-venv \
    rsync \
    xclip \
    yarn \
    zip

# Download and install ripgrep
curl --location --remote-name https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
dpkg -i ripgrep_14.1.0-1_amd64.deb && rm ripgrep_14.1.0-1_amd64.deb

export USERNAME=jordy
export USER_UID=1000
export USER_GID=$USER_UID

# Create the user
groupadd --gid $USER_GID --force $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID --create-home $USERNAME --non-unique

# [Optional] Add sudo support. Omit if no software should be installed after connecting.
apt update \
    && apt install --yes sudo

export GROUP_NAME=$(getent group "$USER_GID" | cut -d: -f1)

echo "%$GROUP_NAME ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$GROUP_NAME
chmod 0440 /etc/sudoers.d/$GROUP_NAME

if [ -d /workspaces ]; then
    chown -R $USER_UID:$USER_GID /workspaces
fi
