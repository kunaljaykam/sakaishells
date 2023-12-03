#!/bin/bash

source config.sh

# Drop the database 'sakaidb' in MySQL, if it exists
if [ -d /var/lib/mysql/sakaidb ]; then
    echo "Dropping and recreating database 'sakaidb'..."
    mysql -u root -proot -Bse "DROP DATABASE sakaidb; CREATE DATABASE sakaidb DEFAULT CHARACTER SET utf8;"
else
    echo "Database 'sakaidb' does not exist."
fi

# Function to remove a directory if it exists
remove_directory() {
    if [ -d "$1" ]; then
        echo "Removing directory $1..."
        rm -rf "$1"
    else
        echo "Directory $1 does not exist."
    fi
}

# Remove specific directories in SAKAI_HOME
remove_directory "$SAKAI_HOME/elasticsearch"
remove_directory "$SAKAI_HOME/samigo"
remove_directory "$SAKAI_HOME/ignite"

echo "Clean-up completed."
