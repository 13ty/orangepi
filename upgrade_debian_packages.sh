#!/bin/bash

# Script to upgrade all Debian packages and distribution packages on Orange Pi Zero 3 with Debian 13

set -e

echo "Updating package lists..."
sudo apt update

echo "Upgrading all installed packages..."
sudo apt upgrade -y

echo "Performing distribution upgrade..."
sudo apt full-upgrade -y

echo "Removing unnecessary packages..."
sudo apt autoremove -y

echo "Upgrade complete. It is recommended to reboot the system if the kernel or core packages were updated."
