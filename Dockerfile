FROM alpine:3.12
RUN apk add --no-cache ca-certificates mailcap curl
RUN set -eux; \
	mkdir -p \
		/config/caddy \
		/data/caddy \
		/etc/caddy \
		/usr/share/caddy

RUN curl -o /tmp/caddy 'https://caddyserver.com/api/download?os=linux&arch=amd64&p=github.com/caddy-dns/cloudflare'
RUN mv /tmp/caddy /usr/bin/caddy && chmod +x /usr/bin/caddy

COPY Caddyfile /etc/caddy/Caddyfile
COPY index.html /usr/share/caddy/index.html

# set up nsswitch.conf for Go's "netgo" implementation
# - https://github.com/docker-library/golang/blob/1eb096131592bcbc90aa3b97471811c798a93573/1.14/alpine3.12/Dockerfile#L9
RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

# See https://caddyserver.com/docs/conventions#file-locations for details
ENV XDG_CONFIG_HOME=/config
ENV XDG_DATA_HOME=/data

VOLUME /config
VOLUME /data

LABEL org.mrkaran.image.version=v2.1.1
LABEL org.mrkaran.image.title=Caddy
LABEL org.mrkaran.image.description="Caddy built with custom plugins"
LABEL org.mrkaran.image.url=https://caddyserver.com
LABEL org.mrkaran.image.documentation=https://caddyserver.com/docs
LABEL org.mrkaran.image.author="mrkaran"
LABEL org.mrkaran.image.licenses=Apache-2.0
LABEL org.mrkaran.image.source="https://github.com/mr-karan/caddy-with-plugins-docker"

EXPOSE 80
EXPOSE 443
EXPOSE 2019

WORKDIR /srv

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
