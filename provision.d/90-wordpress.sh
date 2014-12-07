#!/bin/bash
set -e

cd /vagrant

if [ ! -e latest.tar.gz ]; then
    wget https://wordpress.org/latest.tar.gz
fi

[ -f wordpress/index.php ] && git status --ignored -s wordpress | grep '^!!' | cut -d' ' -f2 | xargs -- rm -r
tar -zxf latest.tar.gz

cp -f wordpress.conf /etc/apache2/sites-available/
a2dissite 000-default.conf
a2ensite wordpress.conf
a2enmod rewrite
service apache2 restart
