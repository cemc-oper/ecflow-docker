FROM nwpc/ecflow:base

LABEL maintainer="perillaroc@gmail.com"

RUN export WK=/tmp/ecFlow-4.10.0-Source \
    && export BOOST_ROOT=/tmp/boost_1_53_0 \
    && cd ${WK} \
    && mkdir build \
    && cd build \
    && cmake .. -DENABLE_SERVER=OFF -DENABLE_PYTHON=ON -DENABLE_UI=OFF -DENABLE_GUI=OFF \
    || echo "cmake has error, but ignored" \
    && CPUS=$(lscpu -p | grep -v '#' | wc -l) \
    && make -j${CPUS} \
    && make install \
    && rm -rf /tmp/*

CMD ["python"]
