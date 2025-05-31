#!/bin/bash

# Script to install and configure Docker on Orange Pi Zero 3 with Debian 13

set -e

echo "Updating package lists..."
sudo apt update

echo "Installing prerequisite packages..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "Adding Docker repository..."
echo "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Updating package lists again..."
sudo apt update

echo "Installing Docker CE..."
sudo apt install -y docker-ce docker-ce-cli containerd.io

echo "Adding current user to docker group..."
sudo usermod -aG docker $USER

echo "Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Docker installation and setup complete. Please log out and log back in to apply group changes."
