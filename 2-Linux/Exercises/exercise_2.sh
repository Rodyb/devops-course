#!/bin/bash

# Update package index
sudo apt-get update

# Install Vim editor (if not already installed)
sudo apt-get install -y vim

# Install Java
sudo apt-get install -y default-jre default-jdk

# Check if Java is installed
if command -v java &> /dev/null; then
    echo "Java is installed."

    # Check Java version
    java_version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')

    # Check if an older Java version is installed
    if [[ "$java_version" < "11" ]]; then
        echo "Java version is lower than 11."
    else
        echo "Java version 11 or higher is installed successfully."
    fi
else
    echo "Java is not installed."
fi
