#!/bin/sh

# Exit shell script when commands fail
set -e

chown -R mysql:mysql /var/lib/mysql

# Check system table is already installed
if [ -d /var/lib/mysql/mysql ]
then
	echo "database already installed"
else
	# Initialization mariadb data directory
	mariadb-install-db --user=mysql 

	# Start mariadbd (server) in background
	mariadbd &

	# Check mariadbd (server) is started
	mariadb-admin ping --wait=1 --connect-timeout=30

	mariadb -u root -hlocalhost -e "ALTER USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; \
	CREATE DATABASE $MYSQL_DATABASE; \
	CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD'; \
	GRANT ALL PRIVILEGES ON wordpress.* To '$MYSQL_USER'@'%'; \
	FLUSH PRIVILEGES; "
	
	# Stop mariadbd (server)
	mariadb-admin -u$MYSQL_ROOT -p$MYSQL_ROOT_PASSWORD shutdown 
fi

# exec mariadbd in foreground
exec "$@"
