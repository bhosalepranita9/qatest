#!/bin/bash

# Configuration variables
SOURCE_DIR="/path/to/your/source/directory"
REMOTE_USER="remote_username"
REMOTE_HOST="remote_host_or_ip"
REMOTE_DIR="/path/to/remote/backup/directory"
REPORT_FILE="/path/to/report.log"

# Function to log messages to the report file
log_message() {
    local log_date=$(date +'%Y-%m-%d %H:%M:%S')
    echo "[$log_date] $1" >> "$REPORT_FILE"
}

# Function to perform the backup
perform_backup() {
    # rsync command to copy contents of SOURCE_DIR to remote server
    rsync -avz --delete "$SOURCE_DIR/" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/"

    # Check the exit status of rsync command
    if [ $? -eq 0 ]; then
        log_message "Backup successful: $(date +'%Y-%m-%d %H:%M:%S')"
    else
        log_message "Backup failed: $(date +'%Y-%m-%d %H:%M:%S')"
    fi
}

# Main script
echo "Starting backup process..."

# Call the backup function
perform_backup

echo "Backup process completed. Report logged to: $REPORT_FILE"

