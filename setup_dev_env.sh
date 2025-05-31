#!/bin/bash

# Script to ensure universe/multiverse repos, install oh-my-zsh or alternative, penv, nvm, and VS Code on Debian 13 (Orange Pi Zero 3)

set -e

echo "Ensuring universe and multiverse repositories are enabled..."

# Backup sources.list
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

# Enable universe and multiverse repos if not present
if ! grep -q "universe" /etc/apt/sources.list; then
    echo "Adding universe repository..."
    sudo sed -i '/^deb / s/$/ universe/' /etc/apt/sources.list
fi

if ! grep -q "multiverse" /etc/apt/sources.list; then
    echo "Adding multiverse repository..."
    sudo sed -i '/^deb / s/$/ multiverse/' /etc/apt/sources.list
fi

echo "Updating package lists..."
sudo apt update

echo "Installing zsh and curl..."
sudo apt install -y zsh curl git

echo "Installing oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "oh-my-zsh already installed."
fi

echo "Installing zoxide for fast terminal navigation..."
if ! command -v zoxide &> /dev/null; then
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
else
    echo "zoxide already installed."
fi

echo "Installing penv (Python environment manager)..."
if ! command -v penv &> /dev/null; then
    pip3 install --user penv
else
    echo "penv already installed."
fi

echo "Installing nvm (Node Version Manager)..."
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
else
    echo "nvm already installed."
fi

echo "Loading nvm..."
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Installing latest Node.js LTS version..."
nvm install --lts

echo "Installing Visual Studio Code..."

# Import Microsoft GPG key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
rm packages.microsoft.gpg

# Add VS Code repository
echo "deb [arch=arm64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

sudo apt update
sudo apt install -y code

echo "Development environment setup complete."
