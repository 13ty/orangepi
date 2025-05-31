#!/bin/bash

# Script to configure UFW firewall for Orange Pi Zero 3 with Debian 13

set -e

echo "Installing UFW firewall..."
sudo apt update
sudo apt install -y ufw

echo "Allowing SSH connections..."
sudo ufw allow ssh

echo "Allowing HTTP and HTTPS for web access..."
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

echo "Enabling UFW firewall..."
sudo ufw --force enable

echo "Firewall status:"
sudo ufw status verbose

echo "Firewall setup complete."
