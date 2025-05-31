#!/bin/bash

# Script to configure automatic system updates on Orange Pi Zero 3 with Debian 13

set -e

echo "Installing unattended-upgrades package..."
sudo apt update
sudo apt install -y unattended-upgrades apt-listchanges

echo "Enabling automatic updates..."
sudo dpkg-reconfigure --priority=low unattended-upgrades

echo "Configuring periodic updates..."
sudo tee /etc/apt/apt.conf.d/20auto-upgrades > /dev/null <<EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
EOF

echo "Automatic updates setup complete."
