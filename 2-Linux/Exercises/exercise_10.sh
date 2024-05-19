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

# Function to set LOG_DIR environment variable
set_log_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "Created log directory: $1"
    fi
    export LOG_DIR=$(realpath "$1")
    echo "LOG_DIR set to: $LOG_DIR"
}

# Function to create a service user
create_service_user() {
    local service_user="myapp"

    # Check if the user already exists
    if id "$service_user" >/dev/null 2>&1; then
        echo "Service user '$service_user' already exists."
    else
        sudo useradd -m "$service_user"
        echo "Service user '$service_user' created."
    fi
}

# Check if log_directory parameter is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <log_directory>"
    exit 1
fi

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

# Create service user
create_service_user

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

# Change ownership of the unzipped package directory to the service user
sudo chown -R myapp:myapp package

# Change into the unzipped package directory
cd package

# Run NodeJS application with the service user
echo -e "\nRunning NodeJS application with service user..."
sudo -u myapp npm install
sudo -u myapp node server.js &

# Wait for the application to start
sleep 5

# Check if the application is running
check_application
