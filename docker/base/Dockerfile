FROM python:3.6

LABEL maintainer="perillaroc@gmail.com"

ARG BOOST_VERSION=1_53_0
ENV BOOST_VERSION ${BOOST_VERSION}
ARG ECFLOW_VERSION=4.17.1
ENV ECFLOW_VERSION ${ECFLOW_VERSION}

COPY . /tmp/ecflow-docker

RUN cp /tmp/ecflow-docker/docker/base/sources.list /etc/apt/sources.list \
    && apt update \
    && apt install -y cmake \
    && rm -rf /var/lib/apt/lists/*

RUN set -ex \
    && cd /tmp/ecflow-docker \
    && ls -l \
    && sh ./docker/base/get_code.sh \
    && cd /tmp \
    && tar zxf boost_${BOOST_VERSION}.tar.gz \
    && tar zxf ecFlow-${ECFLOW_VERSION}-Source.tar.gz \
    \
    && export WK=/tmp/ecFlow-${ECFLOW_VERSION}-Source \
    && export BOOST_ROOT=/tmp/boost_${BOOST_VERSION} \
    \
    && cd ${BOOST_ROOT} \
    && ./bootstrap.sh --with-python=$(which python3) \
    && mv project-config.jam project-config.jam.orig \
    && export python_include_path=$(python -c "import sysconfig;print(sysconfig.get_path('include'))") \
    && export python_version=$(python -c "import sysconfig;print(sysconfig.get_config_var('py_version_short'))") \
    && sed "s|using python.*|using python : ${python_version} : : ${python_include_path} ;|" \
        project-config.jam.orig > project-config.jam \
    && ${WK}/build_scripts/boost_build.sh \
    && cd /tmp \
    && rm -rf ecflow-docker \
    && rm -rf *.tar.gz


CMD ["python"]
