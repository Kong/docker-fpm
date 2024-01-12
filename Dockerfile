FROM ruby:latest@sha256:c33d5e88e65690e34cdac7795b38003ed3cd271c9b3b1641f7ddb263dd1a39dc
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
