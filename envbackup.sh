#!/bin/bash

# Directory to store backups
BACKUP_DIR="/home/csi/managenv"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Iterate through all user home directories
for user_home in /home/*; do
    user_name=$(basename "$user_home")

    # Check if the user has a .env file in their home directory
    if [ -f "$user_home/.env" ]; then
        # Backup the .env file
        backup_file="$BACKUP_DIR/${user_name}_env_backup_$(date +"%Y%m%d%H%M%S").env"
        cp "$user_home/.env" "$backup_file"
        echo "Backup created for user $user_name: $backup_file"
    fi
done

echo "Backup process completed."

