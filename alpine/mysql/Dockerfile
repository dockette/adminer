FROM alpine:edge

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ENV ADMINER_VERSION=4.2.5

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
	apk update && apk upgrade && \
    apk add \
    	wget \
    	ca-certificates \
    	php7@testing \
    	php7-session@testing \
    	php7-mysqli@testing && \
    wget https://www.adminer.org/static/download/$ADMINER_VERSION/adminer-$ADMINER_VERSION.php -O /srv/index.php && \
    apk del wget && \
    rm -rf /var/cache/apk/*

WORKDIR srv
EXPOSE 80

CMD /usr/bin/php7 -S 0.0.0.0:80
