#!/bin/bash

# Get the current user from the USER environment variable
current_user=$USER

# Use ps aux to list all processes and grep for the current user
processes=$(ps aux | grep $current_user)

# Check if any processes were found
if [ -n "$processes" ]; then
    echo "Processes for user $current_user:"
    echo "$processes"

    # Ask the user for input to choose sorting criteria
    echo "Choose sorting criteria:"
    echo "1. Sort by memory consumption"
    echo "2. Sort by CPU consumption"
    read -p "Enter your choice (1 or 2): " choice

    # Sort the processes based on user's choice
    case $choice in
        1)
            sorted_processes=$(echo "$processes" | sort -k4 -rn)
            echo -e "\nSorted by memory consumption:"
            echo "$sorted_processes"
            ;;
        2)
            sorted_processes=$(echo "$processes" | sort -k3 -rn)
            echo -e "\nSorted by CPU consumption:"
            echo "$sorted_processes"
            ;;
        *)
            echo "Invalid choice. No sorting applied."
            ;;
    esac

    # Ask the user for input on how many processes to print
    read -p "Enter the number of processes to print: " num_processes

    # Use head to limit the number of processes to print
    echo -e "\nTop $num_processes processes:"
    echo "$sorted_processes" | head -n $num_processes

else
    echo "No processes found for user $current_user."
fi
