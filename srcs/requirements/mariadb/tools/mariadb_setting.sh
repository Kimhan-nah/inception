#!/bin/sh

echo "start shell script!"

# start mariadbd server on background
mariadb-install-db --user=mysql &
mariadbd

# Query tmp file
echo "make query file"
cat << EOF > query_file
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'
CREATE USER '$MYSQL_USER' IDENTIFIED BY '$MYSQL_PASSWORD';
# GRANT ALL PRIVILEGES ON 
EOF

# check mariadbd (server) started


# Run Query
mariadb < query_file

rm query_file
