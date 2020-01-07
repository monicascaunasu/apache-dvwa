FROM debian:9.2

LABEL maintainer "Monica Scaunasu"

RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    debconf-utils && \ 
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apache2 \
    php \
    php-mysql \
    php-pgsql \
    php-pear \
    php-gd \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY php.ini /etc/php5/apache2/php.ini
COPY dvwa /var/www/html

COPY config.inc.php /var/www/html/config/

RUN chown www-data:www-data -R /var/www/html && \
    rm /var/www/html/index.html



EXPOSE 80

COPY main.sh /
ENTRYPOINT ["/main.sh"]
