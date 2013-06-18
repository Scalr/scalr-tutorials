#!/bin/bash
# Load test configuration and data for Solr

# Crash eagerly
set -e

apt-get -y install curl

SOLR_HOST=%solr_host%
SOLR_PORT=%solr_port%
EXAMPLE_DATA=%example_data%

SOLR_URL=http://$SOLR_HOST:$SOLR_PORT/solr/update
TMP_FILE=/tmp/$$-solr-test.xml

CURL_OPTS="--silent"


echo Starting upload script
echo
echo SOLR_HOST   :   $SOLR_HOST
echo SOLR_PORT   :   $SOLR_PORT
echo SOLR_URL    :   $SOLR_URL

if [ -z "$SOLR_HOST" ] || [ -z "$SOLR_PORT" ];
then
        echo You did not set the SOLR_HOST and / or SOLR_PORT environment vars >&2
        exit 1
fi

# Retrieve and load test data
cd $HOME
curl $CURL_OPTS "$EXAMPLE_DATA" > $TMP_FILE
echo Downloaded Solr resources

echo Posting file $TMP_FILE
echo

curl $CURL_OPTS "$SOLR_URL?commit=true" --data-binary @$TMP_FILE -H 'Content-type:application/xml' 

# Load the data
echo Loaded Solr data

# Clear the temporary file
rm $TMP_FILE
