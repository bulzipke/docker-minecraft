FROM debian:latest
MAINTAINER bulzipke <bulzipke@naver.com>

ENV UID=1000
ENV GID=1000
ENV LD_LIBRARY_PATH=.

RUN apt-get update && apt-get install -y curl unzip nginx libgdiplus cron
RUN S6_VERSION=$(curl -sX GET "https://api.github.com/repos/just-containers/s6-overlay/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]') && \
	curl -o s6-overlay.tar.gz -L "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64.tar.gz" && \
	tar xfz s6-overlay.tar.gz -C / --exclude="./bin" && \
	tar xfz s6-overlay.tar.gz -C /usr ./bin && \
	rm -rf s6-overlay.tar.gz && \
	PAPYRUSCS=$(curl -sX GET "https://api.github.com/repos/mjungnickel18/papyruscs/releases/latest" | grep browser_download_url | grep linux64 | awk '{print $ 2;}' | sed s/\"//g) && \
	curl -o papyruscs.zip -L ${PAPYRUSCS} && \
	unzip papyruscs.zip -d /usr/local/bin && \
	chmod +x /usr/local/bin/PapyrusCs && \
	rm -rf papyruscs.zip

COPY rootfs /
ENTRYPOINT ["/init"]

COPY scripts /root/
CMD ["/root/setup.sh"]

EXPOSE 19132/udp
