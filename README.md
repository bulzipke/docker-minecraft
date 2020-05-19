# docker-minecraft
[![](https://images.microbadger.com/badges/version/bulzipke/minecraft.svg)](https://microbadger.com/images/bulzipke/minecraft) [![](https://images.microbadger.com/badges/image/bulzipke/minecraft.svg)](https://microbadger.com/images/bulzipke/minecraft)

Minecraft Bedrock Server image based on Alpine Linux (not yet)

This image automate run official server binary.

# How to use this Image
```console
$ docker run \
-v /your_minecraft_path:/data \
-v /your_log_path:/logs \
-p 19132:19132/udp \
-p 80:80/tcp \
-d bulzipke/minecraft
```

### Reference   
* [mjungnickel18/papyruscs][0]
* [pogznet/papyruscs][1]

[0]: https://github.com/mjungnickel18/papyruscs
[1]: https://github.com/pogznet/papyruscs


