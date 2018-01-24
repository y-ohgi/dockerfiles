FROM php:7.1-fpm

COPY conf.d/php.ini /usr/local/etc/php/
RUN docker-php-ext-install pdo pdo_mysql

COPY ../docker-compose/php/app /usr/share/nginx/app
VOLUME ["/usr/share/nginx/app"]
