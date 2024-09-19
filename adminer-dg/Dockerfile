FROM alpine:3.20

LABEL maintainer="Milan Sulc <sulcmil@gmail.com>"

ENV ADMINER_DG_VERION=2.0.0
ENV MEMORY=256M
ENV UPLOAD=2048M
ENV WORKERS=4
ENV PHP_CLI_SERVER_WORKERS=${WORKERS}

RUN echo '@community http://nl.alpinelinux.org/alpine/v3.20/community' >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add \
        wget \
        ca-certificates \
        php83@community \
        php83-session@community \
        php83-mysqli@community \
        php83-pgsql@community \
        php83-json@community \
        php83-pecl-mongodb@community \
        tini && \
    wget https://github.com/dg/adminer-custom/archive/v$ADMINER_DG_VERION.tar.gz -O /srv/adminer.tgz && \
    tar zxvf /srv/adminer.tgz --strip-components=1 -C /srv && \
    rm /srv/adminer.tgz && \
    apk del wget ca-certificates && \
    rm -rf /var/cache/apk/*

WORKDIR /srv
EXPOSE 80

ENTRYPOINT ["/sbin/tini", "--"]
CMD [\
    "/usr/bin/php", \
    "-d", \
    "memory_limit=${MEMORY}", \
    "-d", \
    "upload_max_filesize=${UPLOAD}", \
    "-d", \
    "post_max_size=${UPLOAD}", \
    "-S", \
    "0.0.0.0:80" \
    ]
