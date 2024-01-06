# managevenv
better simple management and oversight of virtual environments - meant to interface with autoenv dotenv and makevenv


envbackup.sh:

#!/bin/bash

# Directory to store backups
BACKUP_DIR="/home/($whoami)/managenv"

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


manage_env.sh:

#!/bin/bash

# Check if the script is run as root to manage system-level .env
if [ "$(id -u)" -eq 0 ]; then
    ENV_FILE="/etc/environment"
    echo "Managing system-level .env file: $ENV_FILE"
else
    ENV_FILE="$HOME/.env"
    echo "Managing user-level .env file: $ENV_FILE"
fi

# Display menu options
echo "Select an option:"
echo "1. Add environment variable"
echo "2. Edit environment variable"
echo "3. Delete environment variable"
read -p "Enter your choice: " choice

case $choice in
    1)
        read -p "Enter variable name: " var_name
        read -p "Enter variable value: " var_value
        echo "$var_name=$var_value" >> "$ENV_FILE"
        echo "Variable added successfully."
        ;;
    2)
        read -p "Enter variable name to edit: " var_name
        if grep -q "^$var_name=" "$ENV_FILE"; then
            read -p "Enter new value for $var_name: " new_value
            sed -i "s/^$var_name=.*/$var_name=$new_value/" "$ENV_FILE"
            echo "Variable edited successfully."
        else
            echo "Variable not found."
        fi
        ;;
    3)
        read -p "Enter variable name to delete: " var_name
        if grep -q "^$var_name=" "$ENV_FILE"; then
            sed -i "/^$var_name=/d" "$ENV_FILE"
            echo "Variable deleted successfully."
        else
            echo "Variable not found."
        fi
        ;;
    *)
        echo "Invalid choice."
        ;;
esac


