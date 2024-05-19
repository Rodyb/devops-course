#!/bin/bash

# Function to check if a command is available
check_command() {
    command -v $1 > /dev/null 2>&1 || { echo >&2 "$1 is required but not installed. Aborting."; exit 1; }
}

# Function to print versions
print_versions() {
    echo "NodeJS version: $(node -v)"
    echo "NPM version: $(npm -v)"
}

# Function to check if a process is running on a given port
is_process_running() {
    local port=$1
    local pid=$(sudo lsof -t -i:$port)
    [ -n "$pid" ]
}

# Function to kill a process on a given port
kill_process_on_port() {
    local port=$1
    local pid=$(sudo lsof -t -i:$port)
    if [ -n "$pid" ]; then
        echo "Killing process on port $port (PID: $pid)..."
        sudo kill -9 $pid
        echo "Process killed."
    else
        echo "No process found on port $port."
    fi
}
# Function to check if the application is running
check_application() {
    local process_info=$(ps aux | grep "node server.js" | grep -v grep)
    if [ -n "$process_info" ]; then
        echo -e "\nApplication is running. Process information:"
        echo "$process_info"

        # Extract and print the port information
        local port_info=$(echo "$process_info" | grep -oP '\d{4,5}')
        echo "Application is listening on port: $port_info"

        # Check what is running on port 3000
        echo -e "\nProcesses running on port 3000:"
        sudo lsof -i :3000
    else
        echo -e "\nApplication failed to start. Please check the logs for more information."
        exit 1
    fi
}

# Function to set LOG_DIR environment variable
set_log_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "Created log directory: $1"
    fi
    export LOG_DIR=$(realpath "$1")
    echo "LOG_DIR set to: $LOG_DIR"
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <log_directory>"
    exit 1
fi

log_directory="$1"
# Install NodeJS and NPM
check_command "curl"
check_command "node"
check_command "npm"
check_command "sudo"

# Print installed versions
echo -e "\nInstalled versions:"
print_versions

# Check and kill process on port 3000 if exists
if is_process_running 3000; then
    kill_process_on_port 3000
fi

# Set log directory
log_directory="$1"
set_log_dir "$log_directory"

# Download artifact file
echo -e "\nDownloading artifact..."
artifact_url="https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"
wget -q $artifact_url -O artifact.tgz

# Unzip the downloaded file
echo -e "\nUnzipping artifact..."
tar -xzf artifact.tgz

# Set environment variables
export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret

# Change into the unzipped package directory
cd package

# Run NodeJS application
echo -e "\nRunning NodeJS application..."
npm install
node server.js &

# Wait for the application to start
sleep 5

# Check if the application is running
check_application
