FROM alpine:edge
MAINTAINER bulzipke <bulzipke@naver.com>

RUN apk update && apk upgrade
RUN apk add curl
# zlib libstdc++
# libssl1.1

RUN curl -OL https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.27-r0/glibc-2.27-r0.apk
RUN apk add --allow-untrusted *.apk
RUN rm *.apk

RUN URL=$(curl -s https://minecraft.net/en-us/download/server/bedrock/ | grep bin-linux | sed "s/.*href=['\"]\([^'\"]*\)['\"].*/\1/g"); curl -O $URL
RUN mkdir data
RUN unzip *.zip -d data
RUN rm *.zip

ENV LD_LIBRARY_PATH=.:/usr/lib:/lib
WORKDIR /data
# CMD ./bedrock_server

EXPOSE 19132/udp


