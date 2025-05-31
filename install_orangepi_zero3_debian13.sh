#!/bin/bash

# Script to install packages for Orange Pi Zero 3 with Debian 13
# Installs video playback support, Snap Store (Snapd), SSH server, and developer tools

set -e

echo "Updating package lists..."
sudo apt update

echo "Upgrading existing packages..."
sudo apt upgrade -y

echo "Installing video playback packages..."
# Install Chromium browser and media codecs
sudo apt install -y chromium chromium-driver \
    gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav ffmpeg

echo "Installing Snapd for Snap Store support..."
sudo apt install -y snapd
sudo systemctl enable --now snapd.socket

echo "Installing Flatpak support..."
sudo apt install -y flatpak
# Add Flathub repository for Flatpak apps
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Installing SSH server..."
sudo apt install -y openssh-server
sudo systemctl enable --now ssh

echo "Installing common developer tools..."
sudo apt install -y git build-essential curl vim htop net-tools

echo "Installation complete. Please reboot the system if necessary."
