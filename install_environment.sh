#!/bin/bash

#console colors
. ./common/colors.sh

#MidnightCommander
. ./install/midnightCommander.sh

#PHP
. ./install/php.sh

#Composer
. ./install/composer.sh

#Git
. ./install/git.sh

#MySQL 
. ./install/mysql.sh

#Nginx
. ./install/nginx.sh

#Memcached
. ./install/memcached.sh

#Opensearch
. ./install/opensearch.sh

#Opensearch-Dashboards
. ./install/dashboards.sh

#Munin
. ./install/munin.sh

#RabbitMQ
. ./install/rabbitmq.sh

#MinIO
. ./install/minio.sh

#Redis
. ./install/redis.sh

echo "What do you wish to install?"
PS3="Select operation: "
select yn in MidnightCommander PHP Composer Git MySQL NGINX Memcached Opensearch Opensearch-Dashboards Munin RabbitMQ MinIO Redis Exit; do
    case $yn in
        MidnightCommander ) install_mc;;
        PHP ) install_php;;
        Composer ) install_composer;;
        Git ) install_git;;
        MySQL ) install_mysql;;
        NGINX ) install_nginx;;
        Memcached ) install_memcached;;
        Opensearch ) install_opensearch;;
        Opensearch-Dashboards ) install_dashboards;;
        Munin ) install_munin;;
        RabbitMQ ) install_rabbitmq;;
        MinIO ) install_minio;;
        Redis ) install_redis;;
        Exit ) exit;;
    esac
done
