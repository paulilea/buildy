ARG FROM=php:8.1-alpine
FROM node:16-alpine AS node
FROM $FROM
MAINTAINER Paul Ilea <paul.ilea90@gmail.com>

# add file for https://github.com/pluswerk/grumphp-bom-task
# @see FROM https://github.com/alpine-docker/git
RUN apk --update add file bash rsync git openssh libxml2-dev patch imagemagick libpng-dev unzip jq && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

# install ext-soap ext-mysqli ext-pcov
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN install-php-extensions pcov soap mysqli gd zip exif ldap intl pdo_mysql bcmath opcache
RUN install-php-extensions redis

# @see FROM https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer -O - -q > installer && \
    cat installer | php -- --filename="composer" --install-dir="/bin" && \
    cat installer | php -- --filename="composer1" --1 --install-dir="/bin" && \
    rm installer && \
    composer1 global require hirak/prestissimo && \
    composer1 clear-cache
