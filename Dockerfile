FROM ubuntu:jammy@sha256:e00bd9ad7f936c975dd7c15c71d216f6456aabc39118df7eaa6919d7ddfdb3b0
RUN echo "disabled"

FROM ubuntu:jammy

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
        expect \
    && apt-get install --reinstall -y bash \
    && gem install fpm \
    && mkdir /src/ \
    && fpm --version

WORKDIR /src/

CMD /usr/local/bin/fpm
