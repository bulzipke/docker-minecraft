FROM ubuntu:latest
MAINTAINER bulzipke <bulzipke@naver.com>

RUN apt-get update && apt-get install -y curl unzip

ENV LD_LIBRARY_PATH=.

COPY scripts/* /root/
CMD ["/root/setup.sh"]

EXPOSE 19132/udp

