#!/bin/bash

# Get the current user from the USER environment variable
current_user=$USER

# Use ps aux to list all processes and grep for the current user
processes=$(ps aux | grep $current_user)

# Check if any processes were found
if [ -n "$processes" ]; then
    echo "Processes for user $current_user:"
    echo "$processes"
else
    echo "No processes found for user $current_user."
fi
