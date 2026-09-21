FROM alpine:3.23

LABEL maintainer="Milan Sulc <sulcmil@gmail.com>"

ENV ADMINER_DG_VERION=3.4.1
ENV MEMORY=256M
ENV UPLOAD=2048M
ENV PORT=80
ENV WORKERS=8
ENV PHP_CLI_SERVER_WORKERS=${WORKERS}

RUN echo '@community https://dl-cdn.alpinelinux.org/alpine/v3.23/community' >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add \
        bash \
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

ADD ./adminer-dg/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /srv
EXPOSE 80

ENTRYPOINT ["tini", "--"]
CMD ["/entrypoint.sh"]
