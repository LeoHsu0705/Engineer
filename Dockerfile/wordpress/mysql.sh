#!/bin/bash

sed -i "s/'DB_NAME', 'database_name_here'/'DB_NAME', 'wordpress'/g" /var/www/html/wordpress/wp-config.php
sed -i "s/'DB_USER', 'username_here'/'DB_USER', 'leo'/g" /var/www/html/wordpress/wp-config.php
sed -i "s/'DB_PASSWORD', 'password_here'/'DB_PASSWORD', 'royal1688'/g" /var/www/html/wordpress/wp-config.php
echo "define('FS_METHOD', 'direct');" >> /var/www/html/wordpress/wp-config.php
sed -i "s/\r//g" /var/www/html/wordpress/wp-config.php

service mysql start
sleep 15
DB="wordpress"
USER="leo"
PASS="royal1688"
mysqladmin -u root password "$PASS"
mysql -u root -p$PASS -e "CREATE DATABASE IF NOT EXISTS $DB CHARACTER SET utf8 COLLATE utf8_general_ci; GRANT ALL ON $DB.* TO '$USER'@'localhost' IDENTIFIED BY '$PASS'; FLUSH PRIVILEGES;"
