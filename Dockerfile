FROM php:8.2.27-apache

# Installer les dépendances système et PHP
RUN apt update \
    && apt install -y netcat-openbsd \
    && apt install -y build-essential curl zlib1g-dev g++ git libicu-dev zip libzip-dev \
    libpng-dev libjpeg-dev libwebp-dev libfreetype6-dev libssl-dev pkg-config \
    && docker-php-ext-install intl opcache pdo pdo_mysql \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && docker-php-ext-configure gd --with-freetype --with-webp --with-jpeg \
    && apt clean

# Activer mod_rewrite pour Symfony
RUN a2enmod rewrite

# Copier le code et config Apache
COPY ./app /var/www
COPY ./docker/config/apache/default.conf /etc/apache2/sites-enabled/000-default.conf

# Installation composer
RUN curl -sS https://getcomposer.org/download/2.8.5/composer.phar -o /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

WORKDIR /var/www

# Installer les dépendances PHP
RUN rm composer.lock
RUN composer install --optimize-autoloader --no-scripts

# Créer les dossiers cache et logs
RUN mkdir -p var/cache/prod \
    && mkdir -p var/log
RUN chmod 777 ./var/cache/prod
RUN chmod 777 ./var/log

EXPOSE 80

# Script d'attente de la base de données
COPY wait-for-db.sh /wait-for-db.sh
RUN chmod +x /wait-for-db.sh

CMD ["/wait-for-db.sh"]



