#
# MAINTAINER		midoks <midoks@163.com>
# DOCKER-VERSION 	golang:alpine AS binarybuilder
#
# Dockerizing golang:alpine AS binarybuilder


FROM golang:alpine AS binarybuilder
MAINTAINER  midoks <midoks@163.com>

RUN apk --no-cache --no-progress add --virtual build-deps build-base git linux-pam-dev

WORKDIR /app/echo
COPY . .
#RUN make build TAGS="sqlite cert pam"


FROM alpine:latest
# Install system utils & test runtime dependencies
ADD https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64 /usr/sbin/gosu
RUN chmod +x /usr/sbin/gosu \
  && echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories \
  && apk --no-cache --no-progress add \
    bash \
    ca-certificates \
    curl \
    git \
    linux-pam \
    openssh \
    s6 \
    shadow \
    socat \
    tzdata \
    rsync

RUN apk --no-cache --no-progress add strace

COPY docker/nsswitch.conf /etc/nsswitch.conf

WORKDIR /app/
VOLUME ["/data"]
EXPOSE 22 3000




