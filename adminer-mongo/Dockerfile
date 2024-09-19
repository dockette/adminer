FROM alpine:3.20

LABEL maintainer="Milan Sulc <sulcmil@gmail.com>"

ENV ADMINER_VERSION=4.8.1
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
        php83-pecl-mongodb@community \
        tini && \
    wget https://github.com/vrana/adminer/releases/download/v$ADMINER_VERSION/adminer-$ADMINER_VERSION.php -O /srv/index.php && \
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
