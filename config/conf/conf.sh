#!/bin/sh

# Copyright (c) 2000-2018, Board of Trustees of Leland Stanford Jr. University
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation and/or
# other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its contributors
# may be used to endorse or promote products derived from this software without
# specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

MVN_GRP='org.lockss.laaws'

UI_USER='lockss-u'
UI_PASS='lockss-p'

CFG_GRP="${MVN_GRP}"
CFG_ART='laaws-configuration-service'
CFG_VERSION='1.1.0-SNAPSHOT'
# CFG_HOST set in variant file
CFG_PORT='54420'
CFG_UI='54421'
CFG_CMD="-b config/cluster/bootstrap.txt
         -l config/cluster/cluster.txt
         -l config/cluster/cluster.opt
         -l config/cluster/cluster.${VARIANT}.txt
         -l config/cluster/cluster.${VARIANT}.opt
         -p config/lockss-configuration-service/lockss.txt
         -p config/lockss-configuration-service/lockss.opt"
CFG_URL="http://${UI_USER}:${UI_PASS}@${CFG_HOST}:${CFG_PORT}"

JMS_HOST="${CFG_HOST}"
JMS_PORT='61616'

MDQ_GRP="${MVN_GRP}"
MDQ_ART='laaws-metadata-service'
MDQ_VERSION='1.0.0-SNAPSHOT'
# MDQ_HOST set in variant file
MDQ_PORT='49520'
MDQ_UI='49521'
MDQ_CMD="-b config/cluster/bootstrap.txt
         -c ${CFG_URL}
         -p ${CFG_URL}/config/file/cluster
         -p config/lockss-metadata-service/lockss.txt
         -p config/lockss-metadata-service/lockss.opt
         -p config/lockss-metadata-service/lockss.${VARIANT}.txt
         -p config/lockss-metadata-service/lockss.${VARIANT}.opt"

MDX_GRP="${MVN_GRP}"
MDX_ART='laaws-metadata-extraction-service'
MDX_VERSION='1.1.0-SNAPSHOT'
MDX_PORT='28120'
MDX_UI='28121'
MDX_CMD="-b config/cluster/bootstrap.txt
         -c ${CFG_URL}
         -p ${CFG_URL}/config/file/cluster
         -p config/lockss-metadata-extraction-service/lockss.txt
         -p config/lockss-metadata-extraction-service/lockss.opt
         -p config/lockss-metadata-extraction-service/lockss.${VARIANT}.txt
         -p config/lockss-metadata-extraction-service/lockss.${VARIANT}.opt"

POL_GRP="${MVN_GRP}"
POL_ART='laaws-poller'
POL_VERSION='1.0.0-SNAPSHOT'
POL_PORT='25250'
POL_UI='25251'
POL_CMD="-b config/cluster/bootstrap.txt
         -c ${CFG_URL}
         -p ${CFG_URL}/config/file/cluster
         -p config/lockss-poller/lockss.txt
         -p config/lockss-poller/lockss.opt
         -p config/lockss-poller/lockss.${VARIANT}.txt
         -p config/lockss-poller/lockss.${VARIANT}.opt"

# LAAWS repository service configuration
REPO_GRP="${MVN_GRP}"
REPO_ART='laaws-repository-service'
REPO_VERSION='1.8.0-SNAPSHOT'
REPO_PORT='32640'
REPO_CMD="--spring.config.location=file:./config/lockss-repository-service/demo.properties,file:./config/lockss-repository-service/demo.properties.opt,file:./config/lockss-repository-service/demo.${VARIANT}.properties,file:./config/lockss-repository-service/demo.${VARIANT}.properties.opt"
REPO_JARGS="-Dorg.lockss.jmsUri=tcp://${JMS_HOST}:${JMS_PORT}"
REPO_BASEDIR=/lockss # TODO: Propagate this to projects
REPO_MAX_WARC_SIZE=1048576 # 1 MB

# PostgreSQL database configuration
PGSQL_VERSION='9.6'
# set PGSQL_HOST in variant file
PGSQL_PORT='5432'
POSTGRES_USER=LOCKSS
POSTGRES_PASSWORD=goodPassword
POSTGRES_DB=postgres

# Solr container configuration
# set SOLR_HOST in variant file
SOLR_PORT='8983'
SOLR_CMD='solr-precreate-several.sh demo test-core'

# HDFS container configuration
# HDFS_HOST is set by a variant file
HDFS_FSMD='9000'
HDFS_DATA='50010'
HDFS_MD='50020'
HDFS_STATUI='50070'
HDFS_DNUI='50075'

# PyWb container settings
WAYBACK_URL_HOST='localhost'
WAYBACK_URL_PORT=8080
WAYBACK_BASEDIR=/srv/pywb
WAYBACK_HDFSMNT=/webarchive/hdfs
WAYBACK_WATCHDIR=${WAYBACK_HDFSMNT}/${REPO_BASEDIR}/sealed

# EDINA indexer settings
LOCKSS_SOLR_HDFSMNT=/laaws-demo-hdfs
LOCKSS_SOLR_WATCHDIR=${LOCKSS_SOLR_HDFSMNT}/${REPO_BASEDIR}/sealed
LOCKSS_SOLR_WATCHDIR_INTERVAL=10 # Seconds
LOCKSS_SOLR_URL=http://${SOLR_HOST}:${SOLR_PORT}/solr/test-core

# Demo props server
# set PROPS_HOST in variant file
PROPS_PORT=8001
