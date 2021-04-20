FROM    debian:buster

LABEL   maintainer = "dohlee@student.42seoul.kr"

RUN     apt-get update && apt-get install -y \
        nginx \
        mariadb-server \
        mariadb-client \
        php-mysql \
        php-mysql \
        php-mbstring \
        openssl \
        vim \
        php7.3-fpm \
        wget

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvf latest.tar.gz && mv wordpress var/www/html/

RUN chown -R www-data:www-data /var/www/html/
RUN chmod -R 755 /var/www/html/

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
RUN	tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.2-all-languages phpmyadmin && mv phpmyadmin /var/www/html/


RUN rm phpMyAdmin-5.0.2-all-languages.tar.gz && rm latest.tar.gz

ADD ./srcs/default /etc/nginx/sites-available/default
ADD ./srcs/wp-config.php /var/www/html/wordpress
ADD ./srcs/config.inc.php /var/www/html/phpmyadmin
ADD ./srcs/run.sh ./
ADD ./srcs/dohlee+3.pem etc/ssl/certs/dohlee+3.pem
ADD ./srcs/dohlee+3-key.pem etc/ssl/private/dohlee+3-key.pem

EXPOSE 80 443

CMD bash run.sh

