#!/bin/sh
WARCS=/warcs
if [ -d ${WARCS} ]
then
	find ${WARCS} -type f -name "*.warc" -exec touch {} \;
else
	echo ERROR: WARC file directory ${WARCS} missing.
fi
