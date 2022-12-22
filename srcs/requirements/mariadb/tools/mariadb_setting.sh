#!/bin/sh

# Exit shell script when commands fail
set -e
# set -ex

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

	mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; \
	CREATE DATABASE wordpress; \
	CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY $MYSQL_USER_PASSWORD; \
	GRANT ALL PRIVILEGES ON wordpress.* To '$MYSQL_USER'@'localhost';"
	
	# Query
	# mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root42'; \
	# CREATE DATABASE wordpress; \
	# CREATE USER 'hannkim'@'localhost' IDENTIFIED BY 'hannkim42'; \
	# GRANT ALL PRIVILEGES ON wordpress.* To 'hannkim'@'localhost';"

	# Stop mariadbd (server)
	mariadb-admin -p$MYSQL_ROOT_PASSWORD shutdown 
	# mariadb-admin -proot42 shutdown 
fi

# exec mariadbd in foreground
exec "$@"
