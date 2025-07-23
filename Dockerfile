# Multi-stage build para otimizar a imagem final
FROM node:20-alpine AS node-builder

WORKDIR /app

# Copiar arquivos de dependências
COPY package*.json ./

# Instalar dependências Node.js
RUN npm ci --only=production

# Copiar código fonte
COPY . .

# Build dos assets frontend
RUN npm run build

# Imagem PHP base
FROM php:8.2-fpm-alpine AS php-base

# Instalar dependências do sistema
RUN apk add --no-cache \
    nginx \
    supervisor \
    zip \
    unzip \
    curl \
    sqlite \
    mysql-client \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libzip-dev \
    oniguruma-dev

# Instalar extensões PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        pdo \
        pdo_mysql \
        zip \
        gd \
        mbstring \
        bcmath \
        opcache

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configurar usuário não-root
RUN addgroup -g 1000 -S www && \
    adduser -u 1000 -S www -G www

WORKDIR /var/www

# Copiar código fonte
COPY --chown=www:www . .

# Copiar assets buildados do estágio anterior
COPY --from=node-builder --chown=www:www /app/public/build ./public/build

# Instalar dependências PHP
RUN composer install --optimize-autoloader --no-dev --no-interaction

# Configurar permissões
RUN chown -R www:www /var/www \
    && chmod -R 755 /var/www/storage \
    && chmod -R 755 /var/www/bootstrap/cache

# Configuração do Nginx
COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/php.conf /usr/local/etc/php-fpm.d/www.conf

# Configuração do Supervisor
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Script de inicialização
COPY docker/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Portas expostas
EXPOSE 80

# Usuário final
USER www

# Comando de inicialização
CMD ["/usr/local/bin/start.sh"] 