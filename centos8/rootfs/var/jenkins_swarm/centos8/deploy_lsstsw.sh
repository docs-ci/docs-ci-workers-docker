#!/bin/sh
#
#

cd ${JSW_HOME}
if [ -d "lsstsw" ]; then
  echo "Updatei existing ${JSW_HOME}/lsstsw"
  cd lsstsw
  git pull
else
  echo "Deploy lsst in ${JSW_HOME}"
  git clone https://github.com/lsst/lsstsw
  cd lsstsw
  git checkout tickets/DM-25413
fi

git status
