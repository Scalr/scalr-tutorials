#!/bin/bash
set -o errexit
set -o nounset

LOGFILE=/var/log/build.log


echo "[$(date)] Build Started (%branch%)" | tee -a $LOGFILE

# Build your file here
sleep 10
echo "[$(date)] Build Done" | tee -a $LOGFILE

# Upload the built file here
UPLOAD_TO=s3://build-$$.tar
echo "[$(date)] Build uploaded to: $UPLOAD_TO"

# Notify the rest of the infrastructure
/usr/local/bin/szradm --fire-event=BuildReady url=$UPLOAD_TO
