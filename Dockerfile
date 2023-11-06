FROM alpine:3.18.3

RUN set -x && apk add --no-cache tzdata

RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
  apk add --no-cache --virtual .build-deps alpine-sdk linux-headers cmake lsb-release-minimal && \
  wget "https://github.com/google/or-tools/archive/v9.7.tar.gz" && tar -zxvf v9.7.tar.gz && \
  cd or-tools-9.7 && cmake -S . -B build -DBUILD_DEPS=ON && \
  cmake --build build --config Release --target install -j 4 -v && \
  cd ../ && rm -rf or-tools-9.7 v9.7.tar.gz && \
  apk del .build-deps