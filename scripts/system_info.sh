#!/bin/bash

# Define log file path
LOG_FILE="../logs/system_log_$(date +%Y%m%d).log"

# Gather system information into variables (Like in the image)
WELCOME_MSG="Welcome to System Info, YUSOF!"
CURRENT_DATE=$(date)
DISK_USAGE=$(df -h)
MEMORY_USAGE=$(free -h)
TOP_PROCESSES=$(ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6)

# Format the complete output string
OUTPUT="==========================================
$WELCOME_MSG
Current Date & Time: $CURRENT_DATE
==========================================

--- [ DISK USAGE ] ---
$DISK_USAGE

--- [ MEMORY USAGE ] ---
$MEMORY_USAGE

--- [ TOP 5 RUNNING PROCESSES BY CPU ] ---
$TOP_PROCESSES
=========================================="

# Print to screen and save to log file at the same time
echo "$OUTPUT" | tee "$LOG_FILE"
