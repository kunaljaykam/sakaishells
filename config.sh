#!/bin/bash

# Define the base path for sakaiproject folder where we keep sakai codebase, sakai-home, and tomcat.
BASE_PATH="/home/kunaljaykam/sakaiproject"

# Paths defined with the base path
SAKAI_CODEBASE_DIR="$BASE_PATH/sakai"
SAKAI_HOME="$BASE_PATH/sakai-home"
TOMCAT_VERSION="9.0.89"
TOMCAT_DIR="$BASE_PATH/apache-tomcat-$TOMCAT_VERSION"
TOMCAT_URL="https://dlcdn.apache.org/tomcat/tomcat-9/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.zip"
