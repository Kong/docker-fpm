FROM amd64/ubuntu:bionic@sha256:971a12d7e92a23183dead8bfc415aa650e7deb1cc5fed11a3d21f759a891fde9
RUN echo "disabled"

FROM arm64v8/ubuntu:bionic@sha256:6f911cac13c27a4f9936b949161f57f1fd27228b821e9912815fa941dc7bec7f
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
