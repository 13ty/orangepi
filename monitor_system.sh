#!/bin/bash

# Script to monitor system resources and log usage on Orange Pi Zero 3 with Debian 13

LOGFILE="$HOME/system_monitor.log"

echo "Starting system resource monitoring. Logging to $LOGFILE"
echo "Press Ctrl+C to stop."

while true; do
    echo "----- $(date) -----" >> "$LOGFILE"
    echo "CPU and Memory usage:" >> "$LOGFILE"
    top -b -n1 | head -n 10 >> "$LOGFILE"
    echo "" >> "$LOGFILE"
    echo "Disk usage:" >> "$LOGFILE"
    df -h >> "$LOGFILE"
    echo "" >> "$LOGFILE"
    echo "Network statistics:" >> "$LOGFILE"
    netstat -i >> "$LOGFILE"
    echo "" >> "$LOGFILE"
    sleep 60
done
