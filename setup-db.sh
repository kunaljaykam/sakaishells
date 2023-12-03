#!/bin/bash

# Function to check if MariaDB is installed
is_mariadb_installed() {
    dpkg -s mariadb-server &> /dev/null
}

# Check if MariaDB is installed
if is_mariadb_installed; then
    echo "MariaDB is already installed."
else
    echo "Installing MariaDB server..."
    sudo apt-get update
    sudo apt-get install mariadb-server -y
fi

# Start MariaDB service
sudo service mysql start

# Optionally, secure the MariaDB installation
# Uncomment the next line to run the secure installation
# sudo mysql_secure_installation

# Create database and user
sudo mysql -uroot -Bse "
CREATE DATABASE sakaidb DEFAULT CHARACTER SET utf8;
CREATE USER 'sakaiuser'@'localhost' IDENTIFIED BY 'sakaipassword';
GRANT ALL ON sakaidb.* TO 'sakaiuser'@'localhost';
CREATE USER 'sakaiuser'@'127.0.0.1' IDENTIFIED BY 'sakaipassword';
GRANT ALL ON sakaidb.* TO 'sakaiuser'@'127.0.0.1';
FLUSH PRIVILEGES;
"

echo "Database setup complete."
