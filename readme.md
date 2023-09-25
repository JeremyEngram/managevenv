Environment Variable Manager
This Bash shell script allows you to manage both system-level and user-level .env files for configuring environment variables.

Usage
Download the script to your system.

Make the script executable:

bash
Copy code
chmod +x env_manager.sh
Run the script:

bash
Copy code
./env_manager.sh
Follow the on-screen menu options to add, edit, or delete environment variables in the appropriate .env file.

Note: If the script is run as the root user, it manages the system-level .env file (/etc/environment). Otherwise, it manages the user-level .env file (~/.env).

Options
Add environment variable: Allows you to add a new environment variable by specifying its name and value.

Edit environment variable: Allows you to edit the value of an existing environment variable by specifying its name.

Delete environment variable: Allows you to delete an existing environment variable by specifying its name.

License
This script is provided under the MIT License. Feel free to modify and use it as needed.

You can save the above documentation as a README.md file in the same directory as the script to provide clear instructions to users.
