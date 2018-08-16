FROM alpine:3.8

LABEL RSS Docker image thing

# Bash
RUN apt add --no-cache bash

# Essentials
RUN apt add --no-cache curl nginx git mysql 

# PHP modules
RUN apt add --no-cache php7 php7-json php7-xml php7-mbstring php7-fileinfo php7-opcache php7-fpm php7-gd phpmyadmin

# Initialize
RUN git clone https://git.tt-rss.org/fox/tt-rss.git /var/www/tt-rss
VOLUME [ "/var/log/mysql", "/var/log/nginx", "/var/www/tt-rss" ]

# Expose (open) all ports
EXPOSE 1-65535

# Bash script initializing
COPY init.sh /usr/bin/
CMD ["/usr/bin/init.sh"]