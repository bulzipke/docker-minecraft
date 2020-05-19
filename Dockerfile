FROM debian:latest
MAINTAINER bulzipke <bulzipke@naver.com>

ENV UID=1000
ENV GID=1000
ENV LD_LIBRARY_PATH=.
ENV RENDER_PERIOD=15

RUN apt-get update && apt-get install -y curl unzip cron nginx libgdiplus libc6-dev
RUN S6_VERSION=$(curl -sX GET "https://api.github.com/repos/just-containers/s6-overlay/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]') && \
	curl -o s6-overlay.tar.gz -L "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64.tar.gz" && \
	tar xfz s6-overlay.tar.gz -C / --exclude="./bin" && \
	tar xfz s6-overlay.tar.gz -C /usr ./bin && \
	rm -rf s6-overlay.tar.gz && \
	PAPYRUSCS=$(curl -sX GET "https://api.github.com/repos/mjungnickel18/papyruscs/releases/latest" | grep browser_download_url | grep linux64 | awk '{print $ 2;}' | sed s/\"//g) && \
	curl -o papyruscs.zip -L ${PAPYRUSCS} && \
	unzip papyruscs.zip -d /usr/local/bin && \
	chmod +x /usr/local/bin/PapyrusCs && \
	rm -rf papyruscs.zip && \
	sed -i 's/root \/var\/www\/html/root \/data\/www\/map/g' /etc/nginx/sites-available/default && \
	echo "*/${RENDER_PERIOD} * * * * /root/generate_map.sh >> /logs/generate_map.log 2>&1" > /etc/cron.d/root && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY rootfs /
# ENTRYPOINT ["/init"]

COPY scripts /root/
CMD ["/root/setup.sh"]

EXPOSE 19132/udp
EXPOSE 80/tcp
