# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    clear.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hannkim <hannkim@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/25 16:49:21 by hannkim           #+#    #+#              #
#    Updated: 2022/11/25 16:50:06 by hannkim          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

sudo docker stop $(sudo docker ps -q)
sudo docker rm $(sudo docker ps-aq)
sudo docker rmi $(sudo docker images -q)
