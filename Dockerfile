ARG arch=amd64

FROM balenalib/aarch64-ubuntu:xenial AS arm64
FROM balenalib/amd64-ubuntu:xenial AS amd64

FROM ${arch}

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
		rpm

RUN gem install fpm \
	&& mkdir /src/

WORKDIR /src/

CMD /usr/local/bin/fpm
