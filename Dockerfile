#
# INFRA-DEBIAN-PHP Docker/Codeship Debian with Web Application Components
#
FROM debian:8
MAINTAINER Louie Miranda <lmiranda@gmail.com>

#
# UPDATE AND INSTALLS
#
RUN \
    apt-get update && \
    apt-get -y install \
        nginx \
        curl \
        php5-fpm php5-cli php5-curl php5-intl php5-curl php5-mysql php5-mcrypt php5-common php5-memcached php5-json \
        mysql-client mysql-server \
        memcached \
        awscli \
        phpunit && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin

#
# PHALCON
#
RUN curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | bash && \
    apt-get -y install php5-phalcon

#
# PORTS
#
EXPOSE 80
#EXPOSE 443
EXPOSE 9000

#
# DAEMONIZE / STARTUP
#
RUN sed -i '/daemonize /c daemonize = no' /etc/php5/fpm/php-fpm.conf && \
    sed -i '/^listen /c listen = 0.0.0.0:9000' /etc/php5/fpm/pool.d/www.conf && \
    sed -i 's/^listen.allowed_clients/;listen.allowed_clients/' /etc/php5/fpm/pool.d/www.conf

#CMD ["php5-fpm", "-F"]

#RUN echo "/etc/init.d/php5-fpm start" >> /etc/bash.bashrc
#RUN echo "/etc/init.d/nginx start" >> /etc/bash.bashrc

#CMD ["/usr/sbin/xxxx", "-D", "FOREGROUND"]

RUN service php5-fpm start
RUN service nginx start
RUN service mysql-server start

ADD scripts /scripts
RUN chmod -R 755 /scripts
ENV PATH $PATH:/scripts

# WORKDIR /var/www/vcard