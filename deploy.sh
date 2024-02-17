#!/bin/bash

# Source the configuration file
source config.sh

# Function to check if a command exists
command_exists() {
    command -v "$@" > /dev/null 2>&1
}

# mvn clean install sakai:deploy -Dmaven.tomcat.home=/path/to/tomcat -Dsakai.home=/path/to/sakai-home
# mvn clean install -Dmaven.test.skip=true -T 8 -Dmaven.tomcat.home=/home/kunaljaykam/sakaiproject/apache-tomcat -Dsakai.home=/path/to/sakai-home sakai:deploy


# Check for Java 11
java_installed=false
if command_exists java; then
    JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
    if [[ "$JAVA_VERSION" != 11* ]]; then
        echo "Java 11 is not installed. Current version: $JAVA_VERSION"
        exit 1
    else
        java_installed=true
    fi
else
    echo "Java is not installed."
    exit 1
fi

# Check for Maven
mvn_installed=false
if ! command_exists mvn; then
    echo "Maven is not installed."
    exit 1
else
    mvn_installed=true
fi

#check if sakai.properites file exists in sakai-home



# Proceed only if both Java and Maven are installed
if [ "$java_installed" = true ] && [ "$mvn_installed" = true ]; then
    # Check if Tomcat directory exists
    if [ ! -d "$TOMCAT_DIR" ]; then
        echo "Tomcat directory not found. Please install Tomcat first."
        echo "Run the installation script: install_tomcat.sh"
        exit 1
    fi

    # Navigate to the Sakai codebase directory and run the build command
    if [ -d "$SAKAI_CODEBASE_DIR" ]; then
        cd "$SAKAI_CODEBASE_DIR"
        mvn clean install -Dmaven.test.skip=true -T 8 -Dmaven.tomcat.home=$TOMCAT_DIR -Dsakai.home=$SAKAI_HOME sakai:deploy
    else
        echo "Sakai codebase directory not found. Please check SAKAI_CODEBASE_DIR in config.sh."
        exit 1
    fi
else
    echo "Cannot proceed with deployment. Ensure both Java 11 and Maven are installed."
    exit 1
fi
