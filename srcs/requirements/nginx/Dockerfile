FROM alpine:3.16

RUN apk update && \
		apk add nginx

# COPY ./tools/nginx_setting.sh /tmp/nginx_setting.sh

COPY ./conf/default.conf /etc/nginx/http.d/default.conf

# RUN chmod +x /tmp/nginx_setting.sh

# RUN adduser -D -S -H -u 82 -G www-data www-data

# https port
EXPOSE 80
# EXPOSE 443

# ENTRYPOINT [ "/tmp/nginx_setting.sh" ]

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]