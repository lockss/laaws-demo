#!/bin/sh

# Repository service settings to use
RS_HOST=http://localhost:8700/
RS_REPO=demorepo

# Paths to WARC files
WARC_SRC=`pwd`/warcs
AUID_MAP=$WARC_SRC/auidmap.txt

cd warc-importer

# Import WARC files
while read AUID WARC; do
    #docker run --rm --network laawscluster_default -v $WARC_SRC:/warcs laaws/laaws-repository warcimporter --host $RS_HOST --repo $RS_REPO --auid $AUID /warcs/$WARC
    sh warcimporter --host $RS_HOST --repo $RS_REPO --auid $AUID ../warcs/$WARC
done < $AUID_MAP
