FROM alpine:3.17.0

RUN apk update && \
		apk add nginx

COPY ./tools/nginx_setting.sh /tmp/nginx_setting.sh

# EXPOSE 443

ENTRYPOINT [ "/tmp/nginx_setting.sh" ]