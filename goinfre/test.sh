#!/bin/sh
echo "start shell script!"
apk update
apk add mariadb mariadb-client
mariadb-install-db --user=mysql
# /etc/my.cnf -> [mysql] 'datadir=/var/lib/mysql'
sed 's/[mysql]/[mysql]\ndatadir=/var/lib/mysql' /etc/my.cnf
# mariadbd run in background ??
mariadbd --user=mysql &
