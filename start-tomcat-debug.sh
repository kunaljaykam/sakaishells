#!/bin/bash

# Source the configuration file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$SCRIPT_DIR/config.sh"

# Navigate to the Tomcat directory
cd "$TOMCAT_DIR"

# Start Tomcat with JPDA enabled for debugging
echo "Starting Tomcat with JPDA in $TOMCAT_DIR..."
bin/catalina.sh jpda start

# Optional: Tail the Tomcat log file to view logs in the console
# Uncomment the following line if you want to see the logs
tail -f logs/catalina.out
