FROM alpine:3.16

RUN 		apk update && apk add nginx openssl

COPY		./conf/default.conf /etc/nginx/http.d/default.conf

RUN			openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
			-subj "/C=KR/ST=Seoul/O=42Seoul/OU=GAM" \
			-keyout /etc/ssl/private/hannkim.key -out /etc/ssl/certs/hannkim.crt

EXPOSE		443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
