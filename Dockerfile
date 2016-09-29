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
    apt-get -y install php5-fpm php5-cli php5-gd php5-intl php5-curl php5-mysql php5-redis php5-mcrypt php5-common \
        mysql-client memcached phpunit && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN /usr/sbin/a2dismod 'mpm_*' && /usr/sbin/a2enmod mpm_prefork

#
# PORTS
#
EXPOSE 80
EXPOSE 443

#
# DAEMONIZE
#
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]