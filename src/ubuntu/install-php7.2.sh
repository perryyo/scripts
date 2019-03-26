#!/usr/bin/env bash
add-apt-repository ppa:ondrej/php -y -u

apt-get update

# Fresh PHP modules.
apt install -y \
    php7.2 \
    php7.2-cli \
    php7.2-common

# Additional PHP modules.
apt install -y \
    php7.2-json \
    php7.2-opcache \
    php7.2-mysql \
    php7.2-mbstring \
    php7.2-xml \
    php7.2-zip
