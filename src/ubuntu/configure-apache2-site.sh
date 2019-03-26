#!/usr/bin/env bash

# ./configure-apache2-site example.local /path/to/webroot /path/to/source /public/to/symbolic

HOST=$1
ROOT=$2
SOURCE=$3
SYMBOLIC=$4

CONTENT="$(cat <<-EOF
<VirtualHost *:80>
    # The ServerName directive sets the request scheme, hostname and port that
    # the server uses to identify itself. This is used when creating
    # redirection URLs. In the context of virtual hosts, the ServerName
    # specifies what hostname must appear in the request's Host: header to
    # match this virtual host. For the default virtual host (this file) this
    # value is not decisive as it is used as a last resort host regardless.
    # However, you must set it for any further virtual host explicitly.
    #ServerName www.example.com

    ServerAdmin webmaster@localhost
    ServerName ${HOST}
    DocumentRoot ${ROOT}

    # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
    # error, crit, alert, emerg.
    # It is also possible to configure the loglevel for particular
    # modules, e.g.
    # LogLevel info ssl:warn

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    # For most configuration files from conf-available/, which are
    # enabled or disabled at a global level, it is possible to
    # include a line for only one particular virtual host. For example the
    # following line enables the CGI configuration for this host only
    # after it has been globally disabled with "a2disconf".
    #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
EOF
)"

echo "$CONTENT" > "/etc/apache2/sites-available/${HOST}.conf"

if [ ! -f "/etc/apache2/sites-enabled/${HOST}.conf" ];
then
    a2ensite $HOST

    systemctl apache2 reload
fi

if [ -d "$SOURCE" ] && [ "$SYMBOLIC" != "" ];
then
  ln --symbolic --force "$SOURCE" "$SYMBOLIC"
fi
