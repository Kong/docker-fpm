FROM ruby:latest@sha256:24af4f0bf0af61d04a5ead4f43e7ad468a1b2ff05844d7780555a13a78615ced
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
