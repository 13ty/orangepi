#!/bin/bash

# Script to backup important configuration files on Orange Pi Zero 3 with Debian 13

BACKUP_DIR="$HOME/config_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "Backing up configuration files to $BACKUP_DIR"

# List of important config files and directories
CONFIGS=(
    "/etc/ssh/sshd_config"
    "/etc/ufw"
    "/etc/docker"
    "/etc/apt"
    "/etc/systemd/system"
    "$HOME/.bashrc"
    "$HOME/.profile"
)

for item in "${CONFIGS[@]}"; do
    if [ -e "$item" ]; then
        cp -r "$item" "$BACKUP_DIR"
        echo "Backed up $item"
    else
        echo "Warning: $item not found, skipping."
    fi
done

echo "Backup complete."
