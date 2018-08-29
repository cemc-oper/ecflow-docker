FROM python:3.6

LABEL maintainer="perillaroc@gmail.com"

ARG BOOST_VERSION=1_53_0
ENV BOOST_VERSION ${BOOST_VERSION}
ARG ECFLOW_VERSION=4.10.0
ENV ECFLOW_VERSION ${ECFLOW_VERSION}

RUN apt update \
    && apt install -y cmake \
    && rm -rf /var/lib/apt/lists/*

COPY dist/ecflow_code /tmp/ecflow_code

RUN set -ex \
    && cd /tmp \
    && cp ecflow_code/* . \
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
    && ${WK}/build_scripts/boost_build.sh

CMD ["python"]
