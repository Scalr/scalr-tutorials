#!/bin/sh
URL=http://$SOLR_HOST:$SOLR_PORT/solr/update
FILE=cities.xml

echo Starting upload script
echo
echo "SOLR_HOST   :   $SOLR_HOST"
echo "SOLR_PORT   :   $SOLR_PORT"
echo "URL:        :   $URL"

if [ -z "$SOLR_HOST" ] || [ -z "$SOLR_PORT" ];
then
        echo You did not set the SOLR_HOST and SOLR_PORT environment vars >&2
        exit 1
fi

echo Posting file $FILE to $URL
echo

curl "$URL?commit=true" --data-binary @$FILE -H 'Content-type:application/xml' 

echo
