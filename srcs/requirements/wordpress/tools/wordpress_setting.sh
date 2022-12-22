#!/bin/sh

# Exit shell script when commands fail
set -e
# set -ex

if [ -d /var/www/wordpress ]
then
	echo "wordpress already installed"
else
	# Install wordpress zip file
	wget https://wordpress.org/latest.zip
	unzip latest.zip -d /var/www/
fi

exec "$@"
