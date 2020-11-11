#!/bin/bash

# configuring and running the Jenkins Swarm Worker
if [ -z $JENKINS_MASTER_URL ]; then
    JENKINS_MASTER_URL=https://lsst-docs-ci.ncsa.illinois.edu/jenkins/
fi

if [ -z $JENKINS_SWARM_LABEL ]; then
    JENKINS_SWARM_LABEL="cos7sh"
fi

if [ -z $JENKINS_SWARM_NAME ]; then
    JENKINS_SWARM_NAME=${JENKINS_SWARM_LABEL}
fi

if [ -z $JENKINS_SWARM_EXECUTORS ]; then
    JENKINS_SWARM_EXECUTORS=1
fi

#export JSW_HOME="/var/jenkins_home/${JENKINS_SWARM_NAME}"

# make available lsstsw (if not deployed)
#if [ ! -f "${${JSW_HOME}}.deployed" ]; then
  ${SWARM_HOME}/deploy_lsstsw.sh 2>&1 > ${SWARM_HOME}/deploy_lsstsw.log
#else
  # the Jenkins master may take some time before being up and running
  sleep 30
#fi

java -jar ${SWARM_HOME}/swarm-client.jar \
  -deleteExistingClients \
  -disableSslVerification \
  -disableClientsUniqueId \
  -executors ${JENKINS_SWARM_EXECUTORS} \
  -master ${JENKINS_MASTER_URL} \
  -name ${JENKINS_SWARM_NAME} \
  -labels ${JENKINS_SWARM_LABEL} \
  -tunnel 127.0.0.1:50000 \
  -fsroot "${JSW_HOME}" \
  -username ${SWRB_USR} \
  -password ${SWRB_KEY} 2>&1 > ${SWARM_HOME}/swarm-client.log

