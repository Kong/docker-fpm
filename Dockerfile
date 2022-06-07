FROM amd64/ubuntu:bionic@sha256:8da4e9509bfe5e09df6502e7a8e93c63e4d0d9dbaa9f92d7d767f96d6c20a78a
RUN echo "disabled"

FROM arm64v8/ubuntu:bionic@sha256:6a4619c02fbaf80504f316f42bd4b732831d9590e9c1c0df2b6f294ffbee86c9
RUN echo "disabled"

FROM arm32v7/ubuntu:bionic@sha256:5160a59a5bae201c4eb0a97052a99a609d90d2ef5c6fca75687723ce94bc469b
RUN echo "disabled"

FROM ubuntu:bionic

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
