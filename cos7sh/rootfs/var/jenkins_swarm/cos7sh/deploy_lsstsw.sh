#!/bin/sh
#
#

cd ${JSW_HOME}
if [ -d "lsstsw" ]; then
  echo "Update existing ${JSW_HOME}/lsstsw"
  cd lsstsw
  git pull
else
  echo "Deploy lsst in ${JSW_HOME}"
  git clone https://github.com/gcmshadow/lsstsw
  cd lsstsw
  git checkout u/gcm/shadow
  # when the node is first created, it has to deploy the infrastructure
  # not the parameter -P is used, to not install any new miniconda
  ./bin/deploy -P
  touch .deployed
fi

git status

