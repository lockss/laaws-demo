#!/bin/sh

# waitForService watches docker-compose logs until a regex pattern is first seen by grep
function waitForService() {
    service=$1
    pattern=$2

    echo -n "Waiting for $service..."
    docker-compose logs -f $service | grep -q "$pattern"
    echo "ok"
}

# Check that the demo scripts directory exists
SCRIPTS=./demo.d
if [ ! -d ${SCRIPTS} ]
then
	echo "Script needs directory ${SCRIPTS} with actions to excute when cluster is up."
	exit 1
fi

# Wait for services to come up (this is equivalent to .join() on threads)
waitForService laaws-metadata-pgsql 'database system is ready to accept connections'
waitForService laaws-metadataextractor 'Starting deployment of "laaws-metadata-extraction-service.war"'
waitForService laaws-metadataservice 'Starting deployment of "laaws-metadata-service.war"'
waitForService laaws-openwayback 'Synchronized files'
waitForService laaws-indexer-solr 'Registered new searcher'
waitForService laaws-indexer 'Watch folder'
waitForService laaws-repo-solr 'Registered new searcher'
waitForService laaws-repo-hdfs 'SecondaryNameNode: Checkpoint done'
waitForService laaws-repo 'Started Swagger2SpringBoot'

# Run scripts relative to laaws-demo base directory
for A in ${SCRIPTS}/*
do
	if [ -x ${A} ]
	then
		./${A}
	fi
done
