#!/bin/bash

source config.sh

# Function to monitor logs for errors
monitor_logs() {
    local log_file="$TOMCAT_DIR/logs/catalina.out"

    # Define common error patterns
    local common_errors=("SQLException" "NullPointerException" "IOException" "ClassNotFoundException" "Connection refused")

    echo "Monitoring Tomcat logs for errors..."

    # Tail the log file
    tail -Fn0 "$log_file" | while read line; do
        for error in "${common_errors[@]}"; do
            if [[ "$line" == *"$error"* ]]; then
                echo "Common Error Detected: $error"
                # echo "Log Entry: $line"
                return
            fi
        done
    done
}

# Clear previous Tomcat logs
echo "Clearing previous Tomcat logs..."
rm -f $TOMCAT_DIR/logs/*

# Start Tomcat in debug mode
echo "Starting Tomcat in debug mode..."
$TOMCAT_DIR/bin/catalina.sh jpda start

# Monitor logs for errors
monitor_logs
