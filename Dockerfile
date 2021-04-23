FROM    debian:buster

LABEL   maintainer = "dohlee@student.42seoul.kr"

ENV AUTOINDEX on

RUN	apt-get update && apt-get install -y \
    nginx \
    mariadb-server \
    php-mysql \
    php-mbstring \
    openssl \
    vim \
    wget \
    php7.3-fpm

COPY ./srcs/run.sh ./
COPY ./srcs/wp-config.php ./tmp
COPY ./srcs/config.inc.php ./tmp
COPY ./srcs/index_on ./tmp
COPY ./srcs/index_off ./tmp

EXPOSE 80 443

CMD bash run.sh
