FROM alpine:3.16

RUN apk update && \
			apk add php8 \
							php8-fpm \
							php8-common \
							php8-session \
							php8-iconv \
							php8-json \
							php8-gd \
							php8-curl \
							php8-xml \
							php8-mysqli \
							php8-imap \
							php8-cgi \
							fcgi \
							php8-pdo \
							php8-pdo_mysql \
							php8-soap \
							php8-posix \
							php8-gettext \
							php8-ldap \
							php8-ctype \
							php8-dom \
							php8-simplexml \
							mariadb-client


COPY ./conf/www.conf /etc/php8/php-fpm.d/www.conf

# COPY ./conf/wp-config.php /var/www/wordpress/wp-config.php
COPY ./conf/wp-config.php /tmp/wp-config.php

COPY ./tools/wordpress_setting.sh /tmp/wordpress_setting.sh

RUN chmod +x /tmp/wordpress_setting.sh

RUN adduser -D -S -H -u 82 -G www-data www-data
# RUN adduser -D -S -H -u 82 -G www-data www-data

# RUN adduser -u 1001 -D nginx

# RUN adduser -D nginx && chown -R nginx /var/www/wordpress

EXPOSE 9000

ENTRYPOINT [ "/tmp/wordpress_setting.sh" ]

# for using "docker run --option" (unless too many arguments error)
CMD [ "php-fpm8", "-F" ]
