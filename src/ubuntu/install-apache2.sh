#!/usr/bin/env bash
apt-get update

apt-get install -y apache2

a2enmod rewrite

systemctl restart apache2
