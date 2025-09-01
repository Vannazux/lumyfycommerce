FROM php:8.2-fpm

# Dependências do PHP/Laravel/Bagisto (configura GD corretamente antes da instalação)
RUN apt-get update && apt-get install -y \
    git unzip libicu-dev libonig-dev libzip-dev \
    libpng-dev libjpeg62-turbo-dev libfreetype6-dev \
    libxslt1-dev libxml2-dev libpq-dev \
    build-essential autoconf pkg-config \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-configure intl \
 && docker-php-ext-install intl pdo pdo_mysql bcmath gd zip exif opcache calendar \
 && pecl install redis \
 && docker-php-ext-enable redis \
 && rm -rf /var/lib/apt/lists/*

# (Correção) Aumenta limite de memória do PHP para evitar falhas do Composer em hosts com pouca RAM
RUN echo "memory_limit=512M" > /usr/local/etc/php/conf.d/memory.ini

# Composer (oficial)
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Script de init que faz TUDO (clone/instala/seed/admin/theme/cache)
COPY docker/init-bagisto.sh /usr/local/bin/init-bagisto.sh
RUN chmod +x /usr/local/bin/init-bagisto.sh

# Novo entrypoint que garante que os arquivos do Bagisto existam antes do provisionamento
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expõe porta do PHP-FPM no container (útil para debug)
EXPOSE 9000

# Use o entrypoint que checa/clone e depois executa o init e o CMD
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["php-fpm", "-F"]
