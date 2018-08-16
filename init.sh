#!/bin/bash
# Initiate and pull from master
#rm -rf /var/www/tt-rss
git clone https://git.tt-rss.org/fox/tt-rss.git /var/www/tt-rss

NGINX_conf='
server {
	listen 80 default_server;
	listen [::]:80 default_server;

	root /var/www/tt-rss;

	index index.php index.html index.htm index.nginx-debian.html;

	server_name _;

	location / {
		try_files $uri $uri/ =404;
	}

	location ~ \.php$ {
		include fastcgi.conf;
		fastcgi_pass unix:/run/php/php7.0-fpm.sock;
	}

	location ~ /\.ht {
		deny all;
	}
}
'

echo "${NGINX_conf:1:-1}" | tee /etc/nginx/sites-available/default &> /dev/null 

ln -s /usr/share/webapps/phpmyadmin /var/www/tt-rss/
ln -s /etc/phpmyadmin/config.inc.php /var/www/tt-rss/phpmyadmin-conf.php

nginx -t # checks config

# v  Remove default config        Symlink v     v New config                       v Enable it
rm -f /etc/nginx/sites-enabled/default && ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default 

rc-service nginx restart



