#!/bin/bash
# Pull a config file from S3

# Expected environment (Global Variables)
# $S3_BUCKET: S3 bucket where the config files are
# (optional) $S3_FOLDER: S3 folder where the config files are

# If using S3 auth:
# $AWS_ACCESS_KEY_ID: ID of an access key with access to the file
# $AWS_SECRET_ACCESS_KEY: Associated Secret Acces key

# Debug:
# $DEBUG: If set to a nonzero length string, turn on debug

# Expected Script Variables
# %cnf_file%: Config file we want to pull
# %cnf_location%: Location where we want to move the file


# Install the Boto library to fetch files from S3
apt-get install -y python-boto


# Compute the source address to DL from
SOURCE="s3://$S3_BUCKET"

if [ -n $S3_FOLDER ] && [ $S3_FOLDER ]; then
    SOURCE="$SOURCE/$S3_FOLDER"
fi

SOURCE="$SOURCE/%cnf_file%"


# Echo debug info if required
if [ -n $DEBUG ]; then
    echo Outputting debug info
    echo AWS_ACCESS_KEY_ID     : $AWS_ACCESS_KEY_ID
    echo AWS_SECRET_ACCESS_KEY : $AWS_SECRET_ACCESS_KEY
    echo S3_BUCKET             : $S3_BUCKET
    echo S3_FOLDER             : $S3_FOLDER
    echo cnf_file              : %cnf_file%
    echo cnf_location          : %cnf_location%
fi

echo "Downloading $SOURCE"
fetch_file -o %cnf_location% $SOURCE

if [ $? -eq 1 ]; then
    echo Failed to download.
    echo Check key and credentials
    echo Run with DEBUG on?
    exit 1
fi

exit 0
