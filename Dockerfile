#
# MAINTAINER		midoks <midoks@163.com>
# DOCKER-VERSION 	golang:alpine AS binarybuilder
#
# Dockerizing golang:alpine AS binarybuilder


FROM golang:alpine AS binarybuilder
MAINTAINER  midoks <midoks@163.com>

RUN apk --no-cache --no-progress add --virtual build-deps build-base git linux-pam-dev

WORKDIR /
COPY . .
RUN cd /app/echo && go build main.go


FROM alpine:latest

RUN echo http://mirrors.aliyun.com/alpine/edge/community/ >> /etc/apk/repositories
ADD https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64 /usr/sbin/gosu
RUN chmod +x /usr/sbin/gosu
RUN apk --no-cache --no-progress add \
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
    rsync \
    strace
    
COPY --from=binarybuilder /app/echo/main .
EXPOSE 3000

ENTRYPOINT ["./main"]
