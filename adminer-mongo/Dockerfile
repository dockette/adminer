FROM alpine:3.22

LABEL maintainer="Milan Sulc <sulcmil@gmail.com>"

ENV ADMINER_VERSION=5.4.2
ENV MEMORY=256M
ENV UPLOAD=2048M
ENV PORT=80
ENV WORKERS=8
ENV PHP_CLI_SERVER_WORKERS=${WORKERS}

RUN echo '@community http://nl.alpinelinux.org/alpine/v3.22/community' >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add \
        bash \
        wget \
        unzip \
        ca-certificates \
        php84@community \
        php84-session@community \
        php84-pecl-mongodb@community \
        tini && \
    wget https://github.com/vrana/adminer/releases/download/v$ADMINER_VERSION/adminer-$ADMINER_VERSION.php -O /srv/index.php && \
    wget https://github.com/vrana/adminer/releases/download/v$ADMINER_VERSION/adminer-$ADMINER_VERSION.zip -O /tmp/adminer-$ADMINER_VERSION.zip && \
    unzip /tmp/adminer-$ADMINER_VERSION.zip -d /tmp && \
    mkdir -p /srv/designs && \
    mv /tmp/adminer-$ADMINER_VERSION/designs/* /srv/designs/ 2>/dev/null || true && \
    rm -rf /tmp/* && \
    ln -s /usr/bin/php84 /usr/bin/php && \
    apk del wget unzip ca-certificates && \
    rm -rf /var/cache/apk/*

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /srv
EXPOSE 80

ENTRYPOINT ["tini", "--"]
CMD ["/entrypoint.sh"]
