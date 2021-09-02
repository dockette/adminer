FROM alpine:edge

LABEL maintainer="Milan Sulc <sulcmil@gmail.com>"

ENV ADMINER_DG_VERION=1.28.0
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
        php8-json@testing \
        php8-pecl-mongodb@testing \
        tini && \
    wget https://github.com/dg/adminer-custom/archive/v$ADMINER_DG_VERION.tar.gz -O /srv/adminer.tgz && \
    tar zxvf /srv/adminer.tgz --strip-components=1 -C /srv && \
    rm /srv/adminer.tgz && \
    ln -s /usr/bin/php8 /usr/bin/php && \
    apk del wget ca-certificates && \
    rm -rf /var/cache/apk/*

WORKDIR /srv
EXPOSE 80

ENTRYPOINT ["/sbin/tini", "--"]

CMD /usr/bin/php \
    -d memory_limit=$MEMORY \
    -d upload_max_filesize=$UPLOAD \
    -d post_max_size=$UPLOAD \
    -S 0.0.0.0:80
