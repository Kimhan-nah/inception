FROM alpine:3.16

RUN 		apk update
RUN			apk add nginx
RUN			apk add openssl

# COPY		./tools/setup_nginx.sh /tmp/
COPY ./conf/default.conf /etc/nginx/http.d/default.conf
# COPY		./conf/default /etc/nginx/default.conf

RUN			openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
			-subj "/C=KR/ST=Seoul/O=42Seoul/OU=GON" \
			-keyout /etc/ssl/private/server.key -out /etc/ssl/certs/server.crt

EXPOSE		443

CMD			["nginx", "-g", "daemon off;"]

# RUN apk update && \
# 		apk add nginx openssl

# # COPY ./tools/nginx_setting.sh /tmp/nginx_setting.sh
# COPY ./conf/default.conf /etc/nginx/http.d/default.conf

# # openssl req -new -key 키이름.key -out csr 이름.csr 
# RUN			openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
# 			-subj "/C=KR/ST=Seoul/O=42Seoul/OU=GAM" \
# 			-keyout /etc/ssl/private/hannkim.key -out /etc/ssl/certs/hannkim.crt

# # RUN cd /etc/nginx/http.d/ && \
# # 		openssl genrsa -aes256 -out tmp-ssl.key 2048 && \
# # 		openssl rsa -in tmp-ssl.key -out cert.key && \
# # 		openssl req -new -key cert.key -out cert.csr && \
# # 		openssl x509 -req -days 365 -in cert.csr -signkey cert.key -out cert.crt

# # https port
# EXPOSE 443

# # ENTRYPOINT [ "/tmp/nginx_setting.sh" ]

# ENTRYPOINT [ "nginx", "-g", "daemon off;" ]