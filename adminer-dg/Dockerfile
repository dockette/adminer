FROM alpine:edge

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ENV ADMINER_DG_VERION=1.9.1

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add \
        wget \
        ca-certificates \
        php7@testing \
        php7-session@testing \
        php7-mysqli@testing \
        php7-pgsql@testing \
        php7-json@testing \
        php7-mongodb@testing && \
    wget https://github.com/dg/adminer-custom/archive/v$ADMINER_DG_VERION.tar.gz -O /srv/adminer.tgz && \
    tar zxvf /srv/adminer.tgz --strip-components=1 -C /srv && \
    rm /srv/adminer.tgz && \
    apk del wget ca-certificates && \
    rm -rf /var/cache/apk/*

WORKDIR srv
EXPOSE 80

CMD /usr/bin/php -S 0.0.0.0:80

