FROM php:8.1-cli-alpine

ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

# Crear el directorio de la aplicación
RUN mkdir -p /var/www/html

WORKDIR /var/www/html

# Copiar Composer desde una imagen existente
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Configurar el entorno de usuario
RUN delgroup dialout
RUN addgroup -g ${GID} --system laravel
RUN adduser -G laravel --system -D -s /bin/sh -u ${UID} laravel
RUN apk add --no-cache postgresql-dev $PHPIZE_DEPS

# Configurar PHP con PostgreSQL y Redis
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql
RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/5.3.4.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install redis

# Instalar extensiones necesarias para Octane
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && pecl install swoole \
    && docker-php-ext-enable swoole \
    && apk del .build-deps

# Instalar Octane
RUN composer global require laravel/octane

USER laravel

CMD ["php", "artisan", "octane:start", "--server=swoole", "--host=0.0.0.0", "--port=9000"]
