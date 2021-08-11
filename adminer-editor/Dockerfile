FROM alpine:edge

LABEL maintainer="Milan Sulc <sulcmil@gmail.com>"

ENV ADMINER_EDITOR_VERSION=4.8.1
ENV MEMORY=256M
ENV UPLOAD=2048M
ENV WORKERS=4
ENV PHP_CLI_SERVER_WORKERS=${WORKERS}

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add \
        wget \
        ca-certificates \
        php8@testing \
        php8-session@testing \
        php8-mysqli@community \
        php8-pgsql@testing \
        php8-pecl-mongodb@testing \
        tini && \
    wget https://github.com/vrana/adminer/releases/download/v$ADMINER_EDITOR_VERSION/editor-$ADMINER_EDITOR_VERSION.php -O /srv/index.php && \
    apk del wget ca-certificates && \
    rm -rf /var/cache/apk/*

WORKDIR /srv
EXPOSE 80

ENTRYPOINT ["/tini", "--"]

CMD /usr/bin/php \
    -d memory_limit=$MEMORY \
    -d upload_max_filesize=$UPLOAD \
    -d post_max_size=$UPLOAD \
    -S 0.0.0.0:80
