#!/bin/bash

service mysql start
echo "CREATE DATABASE IF NOT EXISTS wordpress;" \
	| mysql -u root --skip-password
echo "CREATE USER IF NOT EXISTS 'daelee'@'localhost' IDENTIFIED BY 'daelee';" \
	| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'daelee'@'localhost' WITH GRANT OPTION;" \
	| mysql -u root --skip-password

service nginx start
service php7.3-fpm start
service mysql restart
sleep infinity && wait

bash

