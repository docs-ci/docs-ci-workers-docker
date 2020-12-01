#!/bin/sh
#
#

# by default deploy master branch
if [ -z $LSSTSW_BRANCH ]; then
    LSSTSW_BRANCH="master"
fi

# by default deploy lsstsw from github.com/lsst
if [ -z $LSSTSW_URL ]; then
	LSSTSW_URL="https://github.com/lsst/lsstsw"
fi

# by default run bin/deploy without parameters
if [ -z $LSSTSW_PARAMS ]; then
	LSSTSW_PARAMS=""
fi

cd ${HOME}
if [ -d "lsstsw" ]; then
  echo "Update existing ${HOME}/lsstsw"
  cd lsstsw
  git pull
else
  echo "Deploy lsst in ${HOME}"
  git clone $LSSTSW_URL
  cd lsstsw
  git config user.email "docs-ci@lsst.org"
  git config user.name "Docs CI"
  git checkout ${LSSTSW_BRANCH}
  #git checkout tickets/DM-25413
  # when the node is first created, it has to deploy the infrastructure
  # not the parameter -P is used, to not install any new miniconda
  ./bin/deploy "$LSSTSW_PARAMS"
fi

git status

