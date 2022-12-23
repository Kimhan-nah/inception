#!/bin/sh

# Exit shell script when commands fail
set -e
# set -e

sleep 3
chown -R www-data:www-data /var/www/wordpress

if [ -f /var/www/wordpress/index.php ]
then
	echo "wordpress already installed"
else
	# Install wordpress zip file
	wget https://wordpress.org/latest.zip
	unzip latest.zip -d /var/www/
	mv /tmp/wp-config.php /var/www/wordpress/wp-config.php
	# chown -R nginx /var/www/wordpress
fi

exec "$@"
# exec "mariadbd"
