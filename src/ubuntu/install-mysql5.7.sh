#!/usr/bin/env bash

apt-get update

sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password password secret'
sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password_again password secret'
sudo apt -y install mysql-server-5.7
