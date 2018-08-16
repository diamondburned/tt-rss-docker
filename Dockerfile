FROM alpine:3.8

LABEL RSS Docker image thing

# Update
RUN apk update

# Bash and system stuff
RUN apk add --no-cache bash

# Essentials
RUN apk add --no-cache curl nginx git mysql 

# PHP modules
RUN apk add --no-cache php7 php7-json php7-xml php7-plsql php7-mbstring php7-fileinfo php7-opcache php7-fpm php7-gd php7-pdo php7-iconv php7-dom phpmyadmin 

# Initialize
#RUN git clone https://git.tt-rss.org/fox/tt-rss.git /var/www/tt-rss
COPY nginx.conf /etc/nginx/nginx.conf

# Expose (open) ports
EXPOSE 80

# Bash script initializing
COPY init.sh /usr/bin/
RUN chmod +x /usr/bin/init.sh
RUN /usr/bin/init.sh

VOLUME [ "/var/www/tt-rss/config.php" ]

#ENTRYPOINT nginx -c /etc/nginx/nginx.conf
#CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
CMD php-fpm7 -D; nginx -g "daemon off;" -c "/etc/nginx/nginx.conf"