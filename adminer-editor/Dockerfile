FROM alpine:edge

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ENV ADMINER_EDITOR_VERSION=4.7.0
ENV MEMORY=256M
ENV UPLOAD=2048M

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add \
        wget \
        ca-certificates \
        php7.1@testing \
        php7.1-session@testing \
        php7.1-mysqli@testing \
        php7.1-pgsql@testing \
        php7.1-mongodb@testing && \
    wget https://github.com/vrana/adminer/releases/download/v$ADMINER_EDITOR_VERSION/editor-$ADMINER_EDITOR_VERSION.php -O /srv/index.php && \
    apk del wget ca-certificates && \
    rm -rf /var/cache/apk/*

WORKDIR srv
EXPOSE 80

CMD /usr/bin/php \
    -d memory_limit=$MEMORY \
    -d upload_max_filesize=$UPLOAD \
    -d post_max_size=$UPLOAD \
    -S 0.0.0.0:80
