FROM ruby:latest@sha256:6a8cd3ae45904f72fad21739df5b7eed642254a1a44e600ddeeba1322f6af310
RUN echo "disabled"

FROM ruby:latest

ARG FPM_VERSION=1.15.0
ENV FPM_VERSION="${FPM_VERSION}"

ENV DEBIAN_FRONTEND noninteractive

SHELL ["/bin/bash", "-e", "-x", "-c"]

RUN if [[ "$FPM_VERSION" == 'latest' ]]; then \
        gem install --no-document fpm; \
    else \
        gem install --no-document fpm -v "$FPM_VERSION"; \
    fi \
    && mkdir -pv /src/ \
    && fpm --version

WORKDIR /src/

CMD /usr/local/bin/fpm
