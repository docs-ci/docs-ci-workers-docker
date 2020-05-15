#!/bin/bash

if [ -z $JENKINS_MASTER_URL ]; then
    JENKINS_MASTER_URL=https://lsst-docs-ci.ncsa.illinois.edu/jenkins/
fi

if [ -z $JENKINS_SWARM_LABEL ]; then
    JENKINS_SWARM_LABEL=centos8-worker
fi

if [ -z $JENKINS_SWARM_EXECUTORS ]; then
    JENKINS_SWARM_EXECUTORS=1
fi

java -jar ${SWARM_HOME}/swarm-client.jar \
  -disableSslVerification \
  -executors ${JENKINS_SWARM_EXECUTORS} \
  -master ${JENKINS_MASTER_URL} \
  -name ${JENKINS_SWARM_LABEL} \
  -username swarm \
  -password ${SWARM_PWD} 2>&1 > ${SWARM_HOME}/swarm-client.log
