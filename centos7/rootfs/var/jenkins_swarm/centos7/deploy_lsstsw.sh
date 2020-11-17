#!/bin/sh
#
#

if [ -z $LSSTSW_BRANCH ]; then
    LSSTSW_BRANCH="master"
fi

cd ${HOME}
if [ -d "lsstsw" ]; then
  echo "Update existing ${HOME}/lsstsw"
  cd lsstsw
  git pull
else
  echo "Deploy lsst in ${HOME}"
  git clone https://github.com/lsst/lsstsw
  cd lsstsw
  git config user.email "docs-ci@lsst.org"
  git config user.name "Docs CI"
  git checkout ${LSSTSW_BRANCH}
  #git checkout tickets/DM-25413
  # when the node is first created, it has to deploy the infrastructure
  # not the parameter -P is used, to not install any new miniconda
  ./bin/deploy -P
fi

git status

