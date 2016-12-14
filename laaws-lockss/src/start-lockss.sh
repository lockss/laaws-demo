#!/bin/sh

# Display a nice banner
cat /etc/motd

# Make sure that the /cache0/gamma directory exists 
mkdir -p /cache0/gamma/{cache,config,tmp}
chown -R lockss:lockss /cache0/gamma

# Source external resources
. /etc/profile
. /etc/lockss/functions

# Starts a LOCKSS daemon for a given user
start_lockss () {
    if [ ! -r ${CFG_FILE} ]; then
        echo "Can't start ${1}: ${CFG_FILE} missing or not readable"
        exit 1
    fi
    if [ ! -d ${LOG_DIR} ]; then
        mkdir -p ${LOG_DIR}
        chown ${1} ${LOG_DIR}
        chmod 755 ${LOG_DIR}
    fi
    if [ ! -f ${PID_FILE} ]; then
        touch ${PID_FILE}
    fi
    chown ${1} ${PID_FILE}
    chmod 644 ${PID_FILE}
    echo -n "Starting LOCKSS... "
    echo "Starting LOCKSS for user ${1} at `date`" >> ${LOG_FILE}
    chown ${1} ${LOG_FILE}
    /etc/lockss/startdaemon ${1}
    echo "OK"
}

# Start up LOCKSS daemons for all users
set_lockss_user
for A in ${LOCKSS_USER}
do
        set_variables ${A}
        start_lockss ${A}
        unset_variables
done

# XXX This is an ugly hack to solve a race condition
while [ ! -f /var/log/lockss/daemon ]; do
    sleep 0.1s
done

# Follow daemon log
tail -f /var/log/lockss/daemon
