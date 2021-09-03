FROM ubuntu:20.04
ENV TZ=America/Mexico_City
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update &&\
apt-get -y update &&\
apt-get -y upgrade &&\
apt-get -y install apache2
RUN apt-get -y install apt-transport-https 

#Install PHP
RUN apt-get -y install php git \
php-fpm php-pear php-imap php-apcu php-intl php-cgi php-common php-mbstring php-net-socket php-gd php-xml-util php-mysql php-bcmath



#Instalando OSTicket
RUN mkdir /var/www/osTicket
COPY ./osTicket/ /var/www/osTicket/
RUN chown -R www-data:www-data /var/www/*

#Configurar APACHE
RUN rm -rf /etc/apache2/*
COPY Apache_config/ /etc/apache2/
#RUN /etc/init.d/apache2 start

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80 443
