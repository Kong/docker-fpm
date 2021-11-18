FROM amd64/ubuntu:xenial@sha256:a3785f78ab8547ae2710c89e627783cfa7ee7824d3468cae6835c9f4eae23ff7
RUN echo "disabled"

FROM arm64v8/ubuntu:xenial@sha256:70fa660340a344b46cc56b3606dc8abd3bf48b5cbce13d01c720e9793a6bc3c0
RUN echo "disabled"

FROM arm32v7/ubuntu:xenial@sha256:b722e2654241f9681f4719dce7aa16a2f0c35769e17a636f5b39a33967d1aeb8
RUN echo "disabled"

FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

RUN set -x \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        ruby \
        ruby-dev \
        gcc \
        build-essential \
        libffi-dev \
        make \
        ca-certificates \
        libffi-dev \
        ruby-ffi \
        rpm \
        git \
    && apt-get install --reinstall -y bash \
    && gem install fpm \
    && mkdir /src/ \
    && fpm --version

WORKDIR /src/

CMD /usr/local/bin/fpm
