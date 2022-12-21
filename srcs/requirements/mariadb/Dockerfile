FROM alpine:3.17.0

RUN	apk update && \
	apk add mariadb mariadb-client

COPY	--chown=root:root ./tools/maraidb_setting.sh /tmp/mariadb_setting.sh

# check file location
COPY	conf/my.cnf /etc/my.cnf

RUN	chmod +x /tmp/mariadb_setting.sh
	
EXPOSE 3306

# no needed??
# CMD	["/usr/bin/mariadbd"]

ENTRYPOINT ["/tmp/mariadb_setting.sh"]

#VOLUME /var/lib/mysql
