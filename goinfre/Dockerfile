FROM alpine:latest
# execute mariadb_setting.sh
#COPY ./maraidb_setting.sh /mydir/
COPY --chown=root:root ./maraidb_setting.sh /mydir/
ENTRYPOINT ["/mydir/mariadb_setting.sh"]
VOLUME /var/lib/mysql
