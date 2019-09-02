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

COPY --from=binarybuilder /app/echo/main .
EXPOSE 3000

ENTRYPOINT ["./main"]
