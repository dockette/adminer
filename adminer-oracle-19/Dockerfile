FROM dockette/debian:bookworm-slim

LABEL maintainer="Milan Sulc <sulcmil@gmail.com>"

ENV ADMINER_VERSION=5.4.2
ENV MEMORY=256M
ENV UPLOAD=2048M
ENV PORT=80
ENV LD_LIBRARY_PATH="/usr/local/lib;/usr/local/instantclient"
ENV WORKERS=8
ENV PHP_CLI_SERVER_WORKERS=${WORKERS}

# DEPENDENCIES #################################################################
RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt install -y apt-transport-https lsb-release ca-certificates curl wget && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' && \
    apt-get update && \
    apt-get install -y \
        make \
        autoconf \
        g++ \
        unzip \
        libaio1 \
        ca-certificates \
        php8.4 \
        php8.4-dev \
        php8.4-xml \
        php-pear \
        tini && \
    wget https://github.com/vrana/adminer/releases/download/v$ADMINER_VERSION/adminer-$ADMINER_VERSION.php -O /srv/index.php

# OCI8 (ORACLE) ################################################################
RUN wget https://download.oracle.com/otn_software/linux/instantclient/1930000/instantclient-basic-linux.x64-19.30.0.0.0dbru.zip -O /tmp/instantclient-basic-linux.x64-19.30.0.0.0dbru.zip && \
    wget https://download.oracle.com/otn_software/linux/instantclient/1930000/instantclient-sdk-linux.x64-19.30.0.0.0dbru.zip -O /tmp/instantclient-sdk-linux.x64-19.30.0.0.0dbru.zip && \
    unzip -o /tmp/instantclient-basic-linux.x64-19.30.0.0.0dbru.zip -d /usr/local/ && \
    unzip -o /tmp/instantclient-sdk-linux.x64-19.30.0.0.0dbru.zip -d /usr/local/ && \
    ln -s /usr/local/instantclient_19_30 /usr/local/instantclient && \
    ln -sf /usr/local/instantclient/libclntsh.so.19.1 /usr/local/instantclient/libclntsh.so && \
    echo 'instantclient,/usr/local/instantclient' | pecl install oci8 && \
    echo "extension=oci8.so" > /etc/php/8.4/cli/conf.d/00-oci8.ini

# CLEAN UP #####################################################################
RUN apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get remove -y wget && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /srv
EXPOSE 80

ENTRYPOINT ["tini", "--"]
CMD ["/entrypoint.sh"]
