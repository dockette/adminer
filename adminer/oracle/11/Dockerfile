FROM dockette/sid

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ENV ADMINER_VERSION=4.5.0
ENV MEMORY=256M
ENV UPLOAD=2048M
ENV LD_LIBRARY_PATH="/usr/local/lib;/usr/local/instantclient"

RUN apt-get update && \
    apt-get dist-upgrade -y

# DEPENDENCIES #################################################################
RUN apt-get install -y \
        wget \
        make \
        autoconf \
        g++ \
        unzip \
        libaio1 \
        ca-certificates \
        php7.1 \
        php7.1-dev \
        php7.1-xml \
        php-pear && \
    wget https://github.com/vrana/adminer/releases/download/v$ADMINER_VERSION/adminer-$ADMINER_VERSION.php -O /srv/index.php

# OCI8 (ORACLE) ################################################################
RUN wget https://github.com/bumpx/oracle-instantclient/raw/master/instantclient-basic-linux.x64-11.2.0.4.0.zip -O /tmp/instantclient-basic-linux.x64-11.2.0.4.0.zip && \
    wget https://github.com/bumpx/oracle-instantclient/raw/master/instantclient-sdk-linux.x64-11.2.0.4.0.zip -O /tmp/instantclient-sdk-linux.x64-11.2.0.4.0.zip && \
    unzip /tmp/instantclient-basic-linux.x64-11.2.0.4.0.zip -d /usr/local/ && \
    unzip /tmp/instantclient-sdk-linux.x64-11.2.0.4.0.zip -d /usr/local/ && \
    ln -s /usr/local/instantclient_11_2 /usr/local/instantclient && \
    ln -s /usr/local/instantclient/libclntsh.so.11.1 /usr/local/instantclient/libclntsh.so && \
    echo 'instantclient,/usr/local/instantclient' | pecl install oci8 && \
    echo "extension=oci8.so" > /etc/php/7.1/cli/conf.d/00-oci8.ini

# CLEAN UP #####################################################################
RUN apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get remove -y wget curl && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

WORKDIR srv
EXPOSE 80

CMD /usr/bin/php \
    -d memory_limit=$MEMORY \
    -d upload_max_filesize=$UPLOAD \
    -d post_max_size=$UPLOAD \
    -S 0.0.0.0:80
