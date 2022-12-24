# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hannkim <hannkim@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/23 12:30:45 by hannkim           #+#    #+#              #
#    Updated: 2022/11/23 12:30:49 by hannkim          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

PROJECT_NAME	=	inception

USER			=	hannkim

COMPOSE_SOURCE	=	./srcs/docker-compose.yml

VOLUME_PATH		=	/home/$(USER)/data/db \
					/home/$(USER)/data/wordpress

.PHONY	:	all
all		:
			mkdir -p $(VOLUME_PATH)
			docker-compose -f $(COMPOSE_SOURCE) up --build

.PHONY	:	clean
clean	:
			docker-compose -f $(COMPOSE_SOURCE) down

.PHONY	:	fclean
fclean:
			docker-compose -f $(COMPOSE_SOURCE) down \
			--remove-orphans --rmi all -v

.PHONY	:	ffclean
ffclean:	fclean
			sudo rm -rf $(VOLUME_PATH)
			docker image prune
			docker container prune

.PHONY	:	re
re		:	ffclean
			$(MAKE) all

# .PHONY	: restart
# restart	: re all