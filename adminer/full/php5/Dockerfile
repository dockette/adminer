FROM alpine:edge

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ENV ADMINER_VERSION=4.3.1

RUN apk update && apk upgrade && \
    apk add \
        wget \
        ca-certificates \
        php5 \
        php5-pgsql \
        php5-mysql && \
        wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://github.com/sgerrand/alpine-pkg-php5-mongo/releases/download/1.6.14-r0/sgerrand.rsa.pub && \
        wget https://github.com/sgerrand/alpine-pkg-php5-mongo/releases/download/1.6.14-r0/php5-mongo-1.6.14-r0.apk && \
        apk add php5-mongo-1.6.14-r0.apk && \
    wget https://github.com/vrana/adminer/releases/download/v$ADMINER_VERSION/adminer-$ADMINER_VERSION.php -O /srv/index.php && \
    apk del wget ca-certificates && \
    rm -rf /var/cache/apk/*

WORKDIR srv
EXPOSE 80

CMD /usr/bin/php -S 0.0.0.0:80
