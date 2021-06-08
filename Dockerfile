FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends \
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
    && apt-get install --reinstall -y bash

RUN gem install fpm \
    && mkdir /src/

WORKDIR /src/

CMD /usr/local/bin/fpm
