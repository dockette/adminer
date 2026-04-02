FROM dockette/debian:bookworm-slim

LABEL maintainer="Milan Sulc <sulcmil@gmail.com>"

ENV ADMINER_VERSION=5.4.2
ENV MEMORY=256M
ENV UPLOAD=2048M
ENV PORT=80
ENV WORKERS=8
ENV PHP_CLI_SERVER_WORKERS=${WORKERS}

# DEPENDENCIES #################################################################
RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt install -y apt-transport-https lsb-release ca-certificates curl wget gnupg && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' && \
    apt-get update && \
    apt-get install -y \
        make \
        autoconf \
        g++ \
        unzip \
        ca-certificates \
        php8.4 \
        php8.4-dev \
        php8.4-xml \
        php-pear \
        tini && \
    wget https://github.com/vrana/adminer/releases/download/v$ADMINER_VERSION/adminer-$ADMINER_VERSION.php -O /srv/index.php && \
    wget https://github.com/vrana/adminer/releases/download/v$ADMINER_VERSION/adminer-$ADMINER_VERSION.zip -O /tmp/adminer-$ADMINER_VERSION.zip && \
    unzip /tmp/adminer-$ADMINER_VERSION.zip -d /tmp && \
    mkdir -p /srv/designs && \
    mv /tmp/adminer-$ADMINER_VERSION/designs/* /srv/designs/ 2>/dev/null || true && \
    rm -rf /tmp/*

# MSSQL (Microsoft ODBC Driver + PHP extensions) ##############################
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/microsoft-prod.gpg] https://packages.microsoft.com/debian/12/prod bookworm main" > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql18 unixodbc-dev && \
    pecl install sqlsrv pdo_sqlsrv && \
    echo "extension=sqlsrv.so" > /etc/php/8.4/cli/conf.d/20-sqlsrv.ini && \
    echo "extension=pdo_sqlsrv.so" > /etc/php/8.4/cli/conf.d/30-pdo_sqlsrv.ini && \
    sed -i 's/^\[ODBC Driver 18 for SQL Server\]$/&\nEncrypt=Optional/' /etc/odbcinst.ini

# CLEAN UP #####################################################################
RUN apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get remove -y wget make autoconf g++ php8.4-dev php-pear unixodbc-dev && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/* && \
    mkdir -p /srv/adminer-plugins

ADD ./adminer-mssql/entrypoint.sh /entrypoint.sh
ADD ./.plugins/ /srv/plugins-available/
RUN chmod +x /entrypoint.sh

WORKDIR /srv
EXPOSE 80

ENTRYPOINT ["tini", "--"]
CMD ["/entrypoint.sh"]
