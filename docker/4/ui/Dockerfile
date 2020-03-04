FROM nwpc-oper/ecflow-base

LABEL maintainer="perillaroc@gmail.com"

ENV DISPLAY ""

RUN apt update \
    && apt install -y qt5-default libqt5svg5-dev libqt5charts5-dev \
    && rm -rf /var/lib/apt/lists/*

RUN set -ex \
    && export WK=/tmp/ecFlow-${ECFLOW_VERSION}-Source \
    && export BOOST_ROOT=/tmp/boost_${BOOST_VERSION} \
    \
    && cd ${WK} \
    && mkdir build \
    && cd build \
    && cmake .. -DENABLE_SERVER=OFF -DENABLE_PYTHON=OFF -DENABLE_UI=ON -DENABLE_GUI=OFF -DCMAKE_CXX_FLAGS="-w" \
    || echo "cmake has error, but ignored" \
    && CPUS=$(lscpu -p | grep -v '#' | wc -l) \
    && make -j${CPUS} \
    && make install \
    \
    && rm -rf /tmp/*\
    && mkdir -p /srv

WORKDIR /srv
VOLUME /srv

COPY docker/4/ui/docker_entrypoint.sh /srv/docker_entrypoint.sh

RUN set -ex \
    && chmod u+x /srv/docker_entrypoint.sh

ENTRYPOINT ["/srv/docker_entrypoint.sh"]
