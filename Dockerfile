FROM centos:6.6

MAINTAINER takara

WORKDIR /root

RUN yum -y update
RUN yum -y install httpd
RUN yum -y install mysql-server
RUN yum -y install php php-pear php-mysql

ADD env/php.ini /etc/
ADD env/httpd.conf /etc/httpd/conf/
RUN rm -rf /var/www/*
ADD src /var/www/app
RUN chown -R apache.apache /var/www/app

EXPOSE 80

ENTRYPOINT service mysqld start && service httpd start && /bin/bash --login
