FROM ruby:latest@sha256:9afef279599922a4426c91d0a2a0d0c32c15ef0f65490ae83132a683d58ab978
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
