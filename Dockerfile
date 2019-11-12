FROM ruby:2.6.5-alpine3.10

RUN set -x && apk add --no-cache python3 cmake tzdata

RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
  apk add --no-cache --virtual .build-deps git build-base autoconf libtool zlib-dev automake linux-headers swig \
	python3-dev py3-virtualenv  && \
  python3 -m pip install wheel && \
  wget "https://github.com/google/or-tools/archive/v7.4.tar.gz" && tar -zxvf v7.4.tar.gz && \
  cd or-tools-7.4 && make third_party && make install_cc && \
  cd ../ && rm -rf or-tools-7.4 v7.4.tar.gz && \
  apk del .build-deps