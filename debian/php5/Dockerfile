FROM dockette/debian:sid

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ENV ADMINER_VERSION=4.2.5

RUN apt-get update && apt-get install -y \
        wget \
        php5-pgsql \
        php5-mysql \
        php5-sqlite \
        php5-mongo && \
    wget https://www.adminer.org/static/download/$ADMINER_VERSION/adminer-$ADMINER_VERSION.php -O /srv/index.php && \
    apt-get remove -y wget && apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

WORKDIR /srv
EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80"]
