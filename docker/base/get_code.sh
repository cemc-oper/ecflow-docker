#!/usr/bin/env bash
set -ex
cd /tmp
boost_file_name=boost_${BOOST_VERSION}.tar.gz

cd /tmp/ecflow-docker
test -d dist/ecflow_code || mkdir -p dist/ecflow_code
cd dist/ecflow_code


if [ ! -f ${boost_file_name} ]; then
    boost_version_dot=$(echo ${BOOST_VERSION} | sed "s/_/\./g")
    boost_url=https://jaist.dl.sourceforge.net/project/boost/boost/${boost_version_dot}/boost_${BOOST_VERSION}.tar.gz
    wget ${boost_url}
fi
cp ${boost_file_name} /tmp

ecflow_file_name=ecFlow-${ECFLOW_VERSION}-Source.tar.gz

if [ ! -f ${ecflow_file_name} ]; then
    wget https://confluence.ecmwf.int/download/attachments/8650755/${ecflow_file_name}
fi
cp ${ecflow_file_name} /tmp
