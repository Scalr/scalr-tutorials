#!/bin/bash
set -o errexit
set -o nounset

# You could execute pretty much anything here.
# Restart the server, send an alert, attempt to restore replication...
# Here, we'll just write to a file.

NOW=`date`
echo "MySQL replication was down at $NOW" > /tmp/mysql-status
