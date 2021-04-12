FROM    debian:buster

LABEL   maintainer = "dohlee@student.42seoul.kr"

RUN     apt-get update && apt-get install -y \
        nginx \
        mariadb-server \
        php-mysql \
        php-mysql \
        php-mbstring \
        openssl \
        vim \
        php7.3-fpm \
        wget

RUN openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Lee/CN=localhost" -keyout localhost.dev.key -out localhost.dev.crt
RUN mv localhost.dev.crt etc/ssl/certs/ && mv localhost.dev.key etc/ssl/private/
RUN chmod 600 etc/ssl/certs/localhost.dev.crt etc/ssl/private/localhost.dev.key

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvf latest.tar.gz && mv wordpress var/www/html/

RUN chown -R www-data:www-data /var/www/html/
RUN chmod -R 755 /var/www/html

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
RUN	tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.2-all-languages phpmyadmin && mv phpmyadmin /var/www/html/

RUN rm phpMyAdmin-5.0.2-all-languages.tar.gz && rm latest.tar.gz

ADD ./srcs/default /etc/nginx/sites-available/default
ADD ./srcs/wp-config.php /var/www/html/wordpress
ADD ./srcs/config.inc.php /var/www/html/phpmyadmin/
ADD ./srcs/run.sh /

EXPOSE  80 443

CMD     bash run.sh
