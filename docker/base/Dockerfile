FROM python:3.6

LABEL maintainer="perillaroc@gmail.com"

RUN apt update \
    && apt install -y cmake

COPY dist/ecflow_code /tmp/ecflow_code

RUN cd /tmp \
    && cp ecflow_code/* . \
    && tar zxvf boost_1_53_0.tar.gz \
    && tar zxvf ecFlow-4.10.0-Source.tar.gz \
    && export WK=/tmp/ecFlow-4.10.0-Source \
    && export BOOST_ROOT=/tmp/boost_1_53_0 \
    && cd ${BOOST_ROOT} \
    && ./bootstrap.sh --with-python=$(which python3) \
    && mv project-config.jam project-config.jam.orig \
    && sed "s/using python.*/using python : 3\.6 : : \/usr\/local\/include\/python3\.6m ;/" \
    project-config.jam.orig > project-config.jam \
    # && cat project-config.jam \
    && ${WK}/build_scripts/boost_build.sh

CMD ["python"]
