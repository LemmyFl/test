#!/bin/bash

# Define the comment and the cron job
COMMENT="# Perform system maintenance tasks at 6 AM every Sunday, with a random delay up to 59 minutes"
CRON_JOB='0 6 * * 0 sleep $((RANDOM % 3600)) && apt-get update && apt-get -y dist-upgrade && apt-get -y autoremove && apt-get autoclean && sleep 300 && reboot > /dev/null 2>&1'

# Check if the comment and cron job already exist
CRONTAB=$(crontab -l 2>/dev/null)
if ! echo "$CRONTAB" | grep -qF "$COMMENT"; then
    (echo "$CRONTAB"; echo ""; echo "$COMMENT"; echo "$CRON_JOB") | crontab -
fi
