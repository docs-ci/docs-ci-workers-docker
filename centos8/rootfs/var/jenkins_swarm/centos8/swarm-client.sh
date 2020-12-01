#!/bin/bash

# configuring and running the Jenkins Swarm Worker
if [ -z $JENKINS_MASTER_URL ]; then
    JENKINS_MASTER_URL=https://lsst-docs-ci.ncsa.illinois.edu/jenkins/
fi

if [ -z $JENKINS_SWARM_LABEL ]; then
    JENKINS_SWARM_LABEL=centos8
fi

if [ -z $JENKINS_SWARM_NAME ]; then
    JENKINS_SWARM_NAME=${JENKINS_SWARM_LABEL}
fi

if [ -z $JENKINS_SWARM_EXECUTORS ]; then
    JENKINS_SWARM_EXECUTORS=1
fi

export HOME=${JENKINS_HOME}/${JENKINS_SWARM_NAME}

mkdir -p ${HOME}

# make available lsstsw 
${SWARM_HOME}/deploy_lsstsw.sh 2>&1 > ${SWARM_HOME}/deploy_lsstsw.log

# the Jenkins master may take some time before being up and running
sleep 30

java -jar ${SWARM_HOME}/swarm-client.jar \
  -deleteExistingClients \
  -disableSslVerification \
  -disableClientsUniqueId \
  -executors ${JENKINS_SWARM_EXECUTORS} \
  -master ${JENKINS_MASTER_URL} \
  -name ${JENKINS_SWARM_NAME} \
  -labels ${JENKINS_SWARM_LABEL} \
  -tunnel 127.0.0.1:50000 \
  -fsroot "${HOME}" \
  -username ${SWRB_USR} \
  -password ${SWRB_KEY} 2>&1 > ${SWARM_HOME}/swarm-client.log

