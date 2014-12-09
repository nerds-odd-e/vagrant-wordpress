#!/bin/bash
set -e

WORDPRESS_HOME=/vagrant/wordpress

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


echo "Install wp-cli ..."

WP_CLI_HOME=/opt/wp-cli
WP_CLI_CMD=$WP_CLI_HOME/wp
WP_CLI_CONFIG_PATH=$WP_CLI_HOME/config.yml

mkdir -p $WP_CLI_HOME
if [[ ! -e $WP_CLI_CMD ]]; then
    wget --quiet -O /tmp/wp https://raw.github.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    mv /tmp/wp $WP_CLI_CMD
    chmod +x $WP_CLI_CMD
fi

cat > $WP_CLI_CONFIG_PATH <<EOF
path: $WORDPRESS_HOME
color: false
core config:
    dbuser: root
    dbpass:
EOF

cat > /etc/profile.d/wp-cli.sh <<EOF
export WP_CLI_CONFIG_PATH=$WP_CLI_CONFIG_PATH
export PATH=$WP_CLI_HOME:\$PATH
EOF
