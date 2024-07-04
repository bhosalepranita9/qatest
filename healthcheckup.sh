#!/bin/bash

# Define thresholds (adjust these as needed)
CPU_THRESHOLD=80    # CPU usage threshold (%)
MEM_THRESHOLD=80    # Memory usage threshold (%)
DISK_THRESHOLD=80   # Disk usage threshold (%)

# Function to check CPU usage
check_cpu_usage() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
        echo "CPU usage is high: $cpu_usage%" >&2
    fi
}

# Function to check memory usage
check_memory_usage() {
    local memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if (( $(echo "$memory_usage > $MEM_THRESHOLD" | bc -l) )); then
        echo "Memory usage is high: $memory_usage%" >&2
    fi
}

# Function to check disk usage
check_disk_usage() {
    local disk_usage=$(df --output=pcent / | tail -n 1 | sed 's/%//')
    if (( $disk_usage > $DISK_THRESHOLD )); then
        echo "Disk usage is high: $disk_usage%" >&2
    fi
}

# Function to check number of running processes
check_running_processes() {
    local running_processes=$(ps aux | wc -l)
    # Subtract 1 to exclude the header line
    if (( $running_processes > 10 )); then
        echo "Number of running processes is high: $running_processes" >&2
    fi
}

# Main function to run checks
main() {
    echo "Checking system health..."

    check_cpu_usage
    check_memory_usage
    check_disk_usage
    check_running_processes

    echo "Health check completed."
}

# Run the main function
main

