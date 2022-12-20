# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hannkim <hannkim@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/29 16:19:03 by hannkim           #+#    #+#              #
#    Updated: 2022/12/01 14:10:18 by hannkim          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest
MAINTAINER hannkim <hannkim@student.42seoul.kr>

# Install Nginx.
RUN apk add nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx
