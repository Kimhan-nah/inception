FROM alpine:3.17.0

RUN	apk update && \
	apk add mariadb mariadb-client

COPY	--chown=root:root ./tools/mariadb_setting.sh /tmp/mariadb_setting.sh

COPY	./conf/my.cnf /etc/my.cnf

RUN	chmod +x /tmp/mariadb_setting.sh
	
EXPOSE 3306

ENTRYPOINT ["/tmp/mariadb_setting.sh"]

CMD ["mariadbd"]
