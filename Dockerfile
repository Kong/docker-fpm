FROM ruby:latest@sha256:b2f8c67a6db2d899f40bb02adf36e1253b4a8ad1663802ffd6217442bca741aa
RUN echo "disabled"

FROM ruby:latest

ARG FPM_VERSION=1.15.1
ENV FPM_VERSION="${FPM_VERSION}"

ENV DEBIAN_FRONTEND noninteractive

SHELL ["/bin/bash", "-e", "-x", "-c"]

COPY patches/fpm-apk-archive-header.patch /tmp/fpm.patch

RUN set -x \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends rpm \
    && if [[ "$FPM_VERSION" == 'latest' ]]; then \
        gem install --no-document fpm; \
    else \
        gem install --no-document fpm -v "$FPM_VERSION"; \
    fi

# https://github.com/jordansissel/fpm/issues/1227
RUN cd $(gem env gemhome)/gems/fpm-* \
    && patch -p 0 -ruN < /tmp/fpm.patch \
    && mkdir -pv /src/ \
    && fpm --version

WORKDIR /src/

CMD /usr/local/bundle/bin/fpm
