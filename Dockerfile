FROM alpine:latest

RUN set -x && apk add --no-cache python3 cmake tzdata

RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
  apk add --no-cache --virtual .build-deps git build-base autoconf libtool zlib-dev automake linux-headers swig \
	python3-dev py3-virtualenv  && \
  python3 -m pip install wheel && \
  wget "https://github.com/google/or-tools/archive/v6.10.tar.gz" && tar -zxvf v6.10.tar.gz && \
  cd or-tools-6.10 && make third_party && make install_cc && \
  cd ../ && rm -rf or-tools-6.10 v6.10.tar.gz && \
  apk del .build-deps