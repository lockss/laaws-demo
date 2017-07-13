#!/bin/sh

# Touch WARC files for EDINA's Solr indexer
touch warcs/*

# Copy WARC files into OpenWayback watch directory
docker exec -it laawsdemo_laaws-openwayback_1 rm -rf /srv/openwayback/warc
docker exec -it laawsdemo_laaws-openwayback_1 cp -r /warcs /srv/openwayback/warc


#if [ $# -lt 1 ]
#then
#	WARCS=../warcs
#else
#	WARCS=$1
#fi
#if [ -d ${WARCS} ]
#then
#	find ${WARCS} -type f -name "*.warc" -exec touch {} \;
#else
#	echo ERROR: WARC file directory ${WARCS} missing.
#fi
