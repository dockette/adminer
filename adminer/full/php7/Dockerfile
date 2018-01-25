FROM dockette/alpine:edge

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ENV ADMINER_VERSION=4.5.0

RUN echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add \
        wget \
        ca-certificates \
        php7@community \
        php7-session@community \
        php7-mysqli@community \
        php7-pgsql@community \
        php7-mongodb@testing && \
        wget https://github.com/vrana/adminer/releases/download/v$ADMINER_VERSION/adminer-$ADMINER_VERSION.php -O /srv/index.php && \
    apk del wget ca-certificates && \
    rm -rf /var/cache/apk/*

WORKDIR srv
EXPOSE 80

CMD /usr/bin/php -S 0.0.0.0:80
