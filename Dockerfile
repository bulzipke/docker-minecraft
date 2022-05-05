FROM debian:latest
MAINTAINER bulzipke <bulzipke@naver.com>

ENV UID=1000 \
	GID=1000 \
	LD_LIBRARY_PATH=. \
	RENDER_PERIOD=15

COPY rootfs /
COPY scripts /root/

RUN apt-get update && apt-get install -y curl unzip xz-utils cron nginx libgdiplus libc6-dev && \
	S6_VERSION=$(curl -sX GET "https://api.github.com/repos/just-containers/s6-overlay/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]') && \
	curl -o /tmp/s6-overlay-noarch.tar.xz -L "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-noarch.tar.xz" && \
	tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz && \
	curl -o /tmp/s6-overlay-x86_64.tar.xz -L "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-x86_64.tar.xz" && \
	tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz && \
	PAPYRUSCS=$(curl -sX GET "https://api.github.com/repos/papyrus-mc/papyruscs/releases/latest" | grep browser_download_url | grep linux64 | awk '{print $ 2;}' | sed s/\"//g) && \
	curl -o /tmp/papyruscs.zip -L ${PAPYRUSCS} && \
	unzip /tmp/papyruscs.zip -d /usr/local/bin && \
	chmod +x /usr/local/bin/PapyrusCs && \
	chmod +x /etc/cont-init.d/* && \
	chmod +x /root/setup.sh && \
	sed -i 's/root \/var\/www\/html/root \/data\/www\/map/g' /etc/nginx/sites-available/default && \
	rm -rf /tmp/* /var/lib/apt/lists/* && \
	apt-get clean

ENTRYPOINT ["/init"]
CMD ["/root/setup.sh"]

EXPOSE 19132/udp
EXPOSE 80/tcp
