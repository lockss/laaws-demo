#!/bin/sh
if [ $# -lt 1 ]
then
	WARCS=../warcs
else
	WARCS=$1
fi
if [ -d ${WARCS} ]
then
	find ${WARCS} -type f -name "*.warc" -exec touch {} \;
else
	echo ERROR: WARC file directory ${WARCS} missing.
fi
