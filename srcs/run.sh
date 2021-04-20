#!/bin/bash

chmod 775 /run.sh

chown -R mysql:mysql /var/run/mysqld/mysqld.sock
chown -R mysql:mysql /var/run/mysqld/mysqld.sock
chmod -R 644 /var/run/mysqld/mysqld.sock

/etc/init.d/mysql start
echo "CREATE DATABASE IF NOT EXISTS wordpress;" \
	| mysql -u root --skip-password
echo "CREATE USER IF NOT EXISTS 'dohlee'@'localhost' IDENTIFIED BY 'dohlee';" \
	| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'dohlee'@'localhost' WITH GRANT OPTION;" \
	| mysql -u root --skip-password

service nginx start && service php7.3-fpm start
service mysql restart

bash
