#!/bin/bash
# Load test configuration and data for Solr

apt-get -y install curl

TOMCAT_WEBROOT=/var/lib/tomcat6/webapps/ROOT
SOLR_CONF=/etc/solr/conf
SOLR_RESOURCES=https://s3.amazonaws.com/scalr-tutorials/solr
EXAMPLE_DATA=cities.xml
SOLR_URL=http://$SOLR_HOST:$SOLR_PORT/solr/update

CURL_OPTS="--silent"


echo Adding redirect to the Solr admin
cd $TOMCAT_WEBROOT
curl $CURL_OPTS $SOLR_RESOURCES/pages/index.jsp > index.jsp
rm -f index.html

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


# Retrieve configuration files
cd $SOLR_CONF
curl $CURL_OPTS "$SOLR_RESOURCES/conf/schema.xml" > schema.xml
curl $CURL_OPTS "$SOLR_RESOURCES/conf/solrconfig.xml" > solrconfig.xml
curl $CURL_OPTS "$SOLR_RESOURCES/conf/stopwords.txt" > stopwords.txt
echo Loaded Solr config

# Restart Solr with new config
service tomcat6 restart
echo Reloaded Solr

# Retrieve and load test data
cd $HOME
curl $CURL_OPTS "$SOLR_RESOURCES/example-data/$EXAMPLE_DATA" > $EXAMPLE_DATA
echo Downloaded Solr resources

echo Posting file $EXAMPLE_DATA to $SOLR_URL
echo

curl $CURL_OPTS "$SOLR_URL?commit=true" --data-binary @$EXAMPLE_DATA -H 'Content-type:application/xml' 

# Load the data
echo Loaded Solr data
