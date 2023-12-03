#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Source the configuration file from the script's directory
source "$SCRIPT_DIR/config.sh"

# # Navigate to the Sakai codebase directory
# if [ -d "$SAKAI_CODEBASE_DIR" ]; then
#     cd "$SAKAI_CODEBASE_DIR"
# else
#     echo "Sakai codebase directory ($SAKAI_CODEBASE_DIR) not found."
#     exit 1
# fi

# Run the Maven build and deploy command
mvn clean install -Dmaven.test.skip=true -T 8 sakai:deploy -Dmaven.tomcat.home=$TOMCAT_DIR -Dsakai.home=$SAKAI_HOME

