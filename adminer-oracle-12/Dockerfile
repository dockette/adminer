FROM dockette/debian:buster

LABEL maintainer="Milan Sulc <sulcmil@gmail.com>"

ENV ADMINER_VERSION=4.8.1
ENV MEMORY=256M
ENV UPLOAD=2048M
ENV LD_LIBRARY_PATH="/usr/local/lib;/usr/local/instantclient"
ENV WORKERS=4
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
        php8.0 \
        php8.0-dev \
        php8.0-xml \
        php-pear \
        tini && \
    wget https://github.com/vrana/adminer/releases/download/v$ADMINER_VERSION/adminer-$ADMINER_VERSION.php -O /srv/index.php

# OCI8 (ORACLE) ################################################################
RUN wget https://github.com/f00b4r/oracle-instantclient/raw/master/instantclient-basic-linux.x64-12.1.0.2.0.zip -O /tmp/instantclient-basic-linux.x64-12.1.0.2.0.zip && \
    wget https://github.com/f00b4r/oracle-instantclient/raw/master/instantclient-sdk-linux.x64-12.1.0.2.0.zip -O /tmp/instantclient-sdk-linux.x64-12.1.0.2.0.zip && \
    unzip /tmp/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /usr/local/ && \
    unzip /tmp/instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /usr/local/ && \
    ln -s /usr/local/instantclient_12_1 /usr/local/instantclient && \
    ln -s /usr/local/instantclient/libclntsh.so.12.1 /usr/local/instantclient/libclntsh.so && \
    echo 'instantclient,/usr/local/instantclient' | pecl install oci8 && \
    echo "extension=oci8.so" > /etc/php/8.0/cli/conf.d/00-oci8.ini

# CLEAN UP #####################################################################
RUN apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get remove -y wget && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

WORKDIR /srv
EXPOSE 80

ENTRYPOINT ["/sbin/tini", "--"]

CMD /usr/bin/php \
    -d memory_limit=$MEMORY \
    -d upload_max_filesize=$UPLOAD \
    -d post_max_size=$UPLOAD \
    -S 0.0.0.0:80
