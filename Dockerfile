FROM    debian:buster

LABEL   maintainer = "dohlee@student.42seoul.kr"

RUN     apt-get update && apt-get install -y \
        nginx \
        php-mysql \
        php-mysql \
        php-mbstring \
        openssl \
        vim \
        php7.3-fpm \
        wget \
		mariadb-server

RUN wget https://wordpress.org/latest.tar.gz
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz

ADD ./srcs/default /etc/nginx/sites-available/default
ADD ./srcs/wp-config.php ./tmp/wp-config.php
ADD ./srcs/config.inc.php ./tmp/config.inc.php
ADD ./srcs/run.sh /

EXPOSE 80 443

CMD bash run.sh

