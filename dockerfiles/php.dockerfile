FROM php:8.1-fpm-alpine

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

RUN sed -i "s/user = www-data/user = root/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = root/g" /usr/local/etc/php-fpm.d/www.conf
RUN echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf

# Install necessary packages
RUN apk update \
    && apk add --no-cache postgresql-dev \
    && docker-php-ext-install pdo pdo_pgsql


CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]