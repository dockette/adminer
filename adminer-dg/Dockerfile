FROM alpine:3.22

LABEL maintainer="Milan Sulc <sulcmil@gmail.com>"

ENV ADMINER_DG_VERION=3.3.0
ENV MEMORY=256M
ENV UPLOAD=2048M
ENV WORKERS=8
ENV PHP_CLI_SERVER_WORKERS=${WORKERS}

RUN echo '@community http://nl.alpinelinux.org/alpine/v3.22/community' >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add \
        wget \
        ca-certificates \
        php84@community \
        php84-session@community \
        php84-mysqli@community \
        php84-pgsql@community \
        php84-json@community \
        php84-pecl-mongodb@community \
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
