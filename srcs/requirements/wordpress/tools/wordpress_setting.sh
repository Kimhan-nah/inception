#!/bin/sh

# Exit shell script when commands fail
set -x

# Check mariadbd server on
echo "check mariadbd server "
mariadb-admin ping --user=$MYSQL_USER -p$MYSQL_USER_PASSWORD --host=$MYSQL_HOST --wait=1 --connect-timeout=30


if ! wp core is-installed --allow-root --path=/var/www/wordpress; then
	wp core download --allow-root --path=/var/www/wordpress

	# Move /tmp/wp-config.php to /var/www/wordpress/wp-config.php
	cp /tmp/wp-config.php /var/www/wordpress/wp-config.php
	# Set wp-config.php env
	sed -i s/top-secret/${MYSQL_USER_PASSWORD}/ /var/www/wordpress/wp-config.php

	# Install wordpress
	echo "install wordpress"
	wp core install --allow-root --url=${DOMAIN_NAME} \
															--title="hello world" \
															--admin_user=${WP_ADMIN_NAME} \
															--admin_password=${WP_ADMIN_PASSWORD} \
															--admin_email=${WP_ADMIN_EMAIL} --skip-email --path=/var/www/wordpress

	# Create user
	echo "create user"
	wp user create --allow-root ${WP_USER_NAME} ${WP_USER_EMAIL} --role=editor \
														--user_pass=${WP_USER_PASSWORD} --path=/var/www/wordpress
else
	echo "wordpress is already installed."
fi

# php-fpm8 -F 
exec "$@"