FROM ubuntu:latest
MAINTAINER bulzipke <bulzipke@naver.com>

ENV LD_LIBRARY_PATH=.

RUN apt-get update && apt-get install -y curl unzip

RUN mkdir /work
COPY scripts/* /work/
CMD ["/work/setup.sh"]

EXPOSE 19132/udp

