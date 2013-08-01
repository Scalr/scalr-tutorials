#!/bin/bash
set -o errexit
set -o nounset

LOGFILE=/var/log/build.log


echo "[$(date)] Build Ready (%url%)" | tee -a $LOGFILE

# Retrieve the code here, and deploy it
sleep 1

echo "[$(date)] Build Deployed" | tee -a $LOGFILE
