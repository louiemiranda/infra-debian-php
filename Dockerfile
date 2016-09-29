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
        php5-fpm php5-cli php5-curl php5-intl php5-curl php5-mysql php5-mcrypt php5-common php5-memcached \
        mysql-client \
        memcached \
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
#EXPOSE 80
#EXPOSE 443

#
# DAEMONIZE
#
#CMD ["/usr/sbin/xxxx", "-D", "FOREGROUND"]