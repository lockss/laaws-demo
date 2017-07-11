#!/bin/sh

COUNT=0
if [ $# -eq 0 ]
then
	echo Usage: demo-started.sh logfile
	echo logfile is the log output of "docker-compose up"
	exit 1
fi
LOG=$1
SCRIPTS=./demo.d
if [ ! -d ${SCRIPTS} ]
then
	echo "Script needs directory ${SCRIPTS} with actions to excute when cluster is up."
	exit 1
fi
MDQ_UP=0
MDQ_RE='laaws-mdq_.*Starting deployment of .laaws-metadata-service.war.'
MDX_UP=0
MDX_RE='laaws-mdx_.*Starting deployment of .laaws-metadata-extraction-service.war.'
REPO_UP=0
REPO_RE='repo_.*Started Swagger2SpringBoot'
HDFS_UP=0
HDFS_RE='repo-hdfs_.*SecondaryNameNode: Checkpoint done'
INDX_UP=0
INDX_RE='lockss-indexer_.*Watch folder'
PSQL_UP=0
PSQL_RE='metadata-pgsql.*database system is ready to accept connections'
WYBK_UP=0
WYBK_RE='laaws-openwayback_.*Synchronized files'
SLR1_UP=0
SLR1_RE='lockss-solr.*Registered new searcher'
SLR2_UP=0
SLR2_RE='repo-solr_.*Registered new searcher' 
SERVICES=9
while [ ${COUNT} -lt ${SERVICES} ]
do
	if [ ${MDQ_UP} -eq 0 ]
	then
		if grep -q "${MDQ_RE}" ${LOG}
		then
			MDQ_UP=1
			COUNT=`expr ${COUNT} + 1`
		fi
	fi

	if [ ${MDX_UP} -eq 0 ]
	then
		if grep -q "${MDX_RE}" ${LOG}
		then
			MDX_UP=1
			COUNT=`expr ${COUNT} + 1`
		fi
	fi

	if [ ${REPO_UP} -eq 0 ]
	then
		if grep -q "${REPO_RE}" ${LOG}
		then
			REPO_UP=1
			COUNT=`expr ${COUNT} + 1`
		fi
	fi

	if [ ${HDFS_UP} -eq 0 ]
	then
		if grep -q "${HDFS_RE}" ${LOG}
		then
			HDFS_UP=1
			COUNT=`expr ${COUNT} + 1`
		fi
	fi

	if [ ${INDX_UP} -eq 0 ]
	then
		if grep -q "${INDX_RE}" ${LOG}
		then
			INDX_UP=1
			COUNT=`expr ${COUNT} + 1`
		fi
	fi

	if [ ${PSQL_UP} -eq 0 ]
	then
		if grep -q "${PSQL_RE}" ${LOG}
		then
			PSQL_UP=1
			COUNT=`expr ${COUNT} + 1`
		fi
	fi

	if [ ${WYBK_UP} -eq 0 ]
	then
		if grep -q "${WYBK_RE}" ${LOG}
		then
			WYBK_UP=1
			COUNT=`expr ${COUNT} + 1`
		fi
	fi

	if [ ${SLR1_UP} -eq 0 ]
	then
		if grep -q "${SLR1_RE}" ${LOG}
		then
			SLR1_UP=1
			COUNT=`expr ${COUNT} + 1`
		fi
	fi

	if [ ${SLR2_UP} -eq 0 ]
	then
		if grep -q "${SLR2_RE}" ${LOG}
		then
			SLR2_UP=1
			COUNT=`expr ${COUNT} + 1`
		fi
	fi
	if [ ${COUNT} -lt ${SERVICES} ]
	then
		sleep 30
	fi
done
cd ${SCRIPTS}
for A in *
do
	if [ -x ${A} ]
	then
		./${A}
	fi
done
