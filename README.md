# caddy-plugins-docker

## Using the image

`docker pull mrkaran/caddy:latest`

### List of plugins included

- [caddy-dns/cloudflare/](https://github.com/caddy-dns/cloudflare/)

### Caution

`caddy` comes with support for lot of extra `Go` plugins which need to be included while building `caddy` from source.

Currently the Dockerfile uses the binary from Caddy [Downloads](https://caddyserver.com/download) page as a makeshift solution since building `caddy` with extra plugins using `xcaddy` fails right now because of [this](https://github.com/caddy-dns/cloudflare/issues/11) issue. Whenever there's a fix, the `Dockerfile` will be updated to include the same.

As a result of this, the image is **NOT** immutable and everytime it is built, the latest binary is fetched. You have been warned.
