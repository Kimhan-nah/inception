# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    inception.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hannkim <hannkim@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/25 16:47:44 by hannkim           #+#    #+#              #
#    Updated: 2022/11/25 16:57:11 by hannkim          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# su -
apt update
apt install -y sudo
sudo apt install -y apt-transport-https
sudo apt install -y ssh
sudo apt install -y ca-certificates
sudo apt install -y curl
sudo apt install -y software-properties-common
sudo apt install -y git
sudo apt install -y make
sudo apt install -y vim
sudo apt install -y systemd
# sudo apt install -y gpg?

# docker on Debian 11
sudo apt install -y docker
sudo chmod 666 /var/run/docker.sock
sudo chmod +x /usr/run/docker-compose
sudo systemctl restart docker

# google chrome for using wordpress
