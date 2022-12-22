FROM alpine:3.17.0

RUN apk update && \
			apk add php81-common && \
							php81-session && \
							php81-iconv && \
							php81-json && \
							php81-gd && \
							php81-curl && \
							php81-xml && \
							php81-mysqli && \
							php81-imap && \
							php81-cgi && \
							fcgi && \
							php81-pdo && \
							php81-pdo_mysql && \
							php81-soap && \
							php81-posix && \
							php81-gettext && \
							php81-ldap && \
							php81-ctype && \
							php81-dom && \
							php81-simplexml && \
							mariadb-client

COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

COPY ./conf/wp-config.conf /wordpess/wp-config.php

COPY ./tools/wordpres_setting.sh /tmp/wordpress_setting.sh

RUN chmod +x /tmp/wordpress_setting.sh

EXPOSE 9000

ENTRYPOINT [ "/tmp/wordpress_setting.sh" ]

# for using "docker run --option" (unless too many arguments error)
CMD [ "php-fpm81", "-F" ]
