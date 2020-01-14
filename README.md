# docker-minecraft
[![](https://images.microbadger.com/badges/version/bulzipke/minecraft.svg)](https://microbadger.com/images/bulzipke/minecraft) [![](https://images.microbadger.com/badges/image/bulzipke/minecraft.svg)](https://microbadger.com/images/bulzipke/minecraft)

Minecraft Bedrock Server image based on Alpine Linux (not yet)

This image automate run official server binary.

# How to use this Image
```console
$ docker run \
-v /your_path:/data \
-p 19132:19132/udp \
-d bulzipke/minecraft
```
