#!/bin/bash

# Source the configuration file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$SCRIPT_DIR/config.sh"

# Navigate to the Tomcat directory
cd "$TOMCAT_DIR"

# Stop Tomcat
echo "Stopping Tomcat in $TOMCAT_DIR..."
bin/catalina.sh stop