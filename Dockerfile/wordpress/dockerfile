FROM ubuntu:18.04

RUN apt-get update -y && apt-get install curl -y  && apt-get install vim -y && apt-get install php7.2-fpm -y && apt-get install php-mysql -y && apt-get install php-curl -y && apt-get install php-gd -y && apt-get install php-mbstring -y && apt-get install php-xml -y && apt-get install php-xmlrpc -y

###################################################################################################################################################

RUN apt-get install nginx -y

###################################################################################################################################################

RUN apt-get install mariadb-server -y
COPY wordpress.conf /etc/nginx/conf.d/

WORKDIR /var/www/html/
RUN curl -O https://wordpress.org/latest.tar.gz 
RUN tar xzvf latest.tar.gz
RUN cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
COPY mysql.sh /tmp/mysql.sh
RUN /bin/bash /tmp/mysql.sh

CMD service mysql start && service php7.2-fpm start && nginx -g "daemon off;"
