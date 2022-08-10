FROM amd64/ubuntu:bionic@sha256:e4771b7160543c6e43968b4e9795be9ddcad9d573edd7cd7aebd3ce61326fc7a
RUN echo "disabled"

FROM arm64v8/ubuntu:bionic@sha256:8c646d06cb9c9b9c24c004704a313dd3e23a783989b5b155fcc4a5b2796fc90c
RUN echo "disabled"

FROM arm32v7/ubuntu:bionic@sha256:f0e293e967551be5f21f8d1c60c8cd3c58f341547f98cb65cc2ad1fb7839b045
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
        gpg \
        gpg-agent \
    && apt-get install --reinstall -y bash \
    && gem install fpm \
    && mkdir /src/ \
    && fpm --version

WORKDIR /src/

CMD /usr/local/bin/fpm
