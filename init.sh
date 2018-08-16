#!/bin/bash

# Initiate and pull from master
#rm -rf /var/www/tt-rss
git clone --progress --verbose --depth=1 https://git.tt-rss.org/fox/tt-rss.git /var/www/tt-rss
sudo chown -R root:root /var/www
sudo chmod -R 775 /var/www

echo "define('_SKIP_SELF_URL_PATH_CHECKS', true);" | tee /var/www/tt-rss/config.php
#echo "${NGINX_conf:1:-1}" | tee /etc/nginx/nginx.conf &> /dev/null 
#echo "${NGINX_fastcgi_conf:1:-1}" | tee /etc/nginx/fastcgi.conf &> /dev/null

ln -s /usr/share/webapps/phpmyadmin /var/www/tt-rss/
ln -s /etc/phpmyadmin/config.inc.php /var/www/tt-rss/phpmyadmin-conf.php

# Initialize NGINX
mkdir -p /run/nginx
nginx -t # checks config

#ls /run/
