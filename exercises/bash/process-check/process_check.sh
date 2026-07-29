#!/bin/bash

# Defines the variables
CURRENT_USER=$(whoami)
PROCESS_LIMIT=7
ISSUE_COUNT=0


# Checks whether a process is running
check_process() {
    local process_name=$1 # Takes the name of the process to check as an argument
    if pgrep  "$process_name" > /dev/null; then # Uses pgrep to check whether the process is running
        return 0
    else
        return 1
    fi
}



if [ $EUID -ne 0 ]; then # Checks whether the user is root
    echo "Error: This script must be run as root."
    exit 1
fi



mkdir "/root/permissions_folder" 2>/dev/null
if [ $? -ne 0 ]; then # Checks whether the folder was created successfully by reading the exit status
    echo "The permissions_folder already exists."
else
    echo "Folder created successfully in /root."
fi




echo "Process analysis for user = $CURRENT_USER"

PROCESS_TO_CHECK=("md" "systemd" "zombie_process" "ssh")  # List of processes to check

for process_name in "${PROCESS_TO_CHECK[@]}"; do
    if check_process "$process_name"; then
        echo "The process $process_name is running"
    else
        echo "The process $process_name is not running"
        ((ISSUE_COUNT++)) # Increments the number of issues found
    fi
done


# Checks the total number of running processes
TOTAL_PROCESSES=$(ps aux | wc -l)  # Counts the total number of running processes using ps and wc

echo "Final summary:"
echo "Total processes found = $TOTAL_PROCESSES"
echo "Issues found = $ISSUE_COUNT" # Prints the number of issues found

exit 0
