# Stop NGINX as it's not ready
service nginx stop

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

ln -s /usr/share/phpmyadmin /var/www/tt-rss/

nginx -t # checks config

# v  Remove default config        Symlink v     v New config                       v Enable it
rm -f /etc/nginx/sites-enabled/default && ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default 

service nginx start

