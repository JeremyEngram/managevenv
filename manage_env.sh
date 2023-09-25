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
