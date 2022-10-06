FROM ubuntu:jammy@sha256:35fb073f9e56eb84041b0745cb714eff0f7b225ea9e024f703cab56aaa5c7720
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
