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
							mariadb-client \
							php-phar \
							curl

# Install wp-cli
# Add 'www-data' user for nginx(included 'www-data' grouup)
# Initialize '/var/www/wordpress' database directory
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	chmod +x /usr/local/bin/wp && \
	mkdir -p /var/www/wordpress && \
	adduser -D -S -H -u 82 -G www-data www-data && \
	chown -R www-data:www-data /var/www/wordpress

# Copy php-fpm config file
COPY ./conf/www.conf /etc/php8/php-fpm.d/www.conf

# Copy wp config file
COPY ./conf/wp-config.php /tmp/wp-config.php

# Copy entrypoint shell script
COPY ./tools/wordpress_setting.sh /tmp/wordpress_setting.sh

RUN chmod +x /tmp/wordpress_setting.sh

EXPOSE 9000

ENTRYPOINT [ "/tmp/wordpress_setting.sh", "php-fpm8", "-F"]

