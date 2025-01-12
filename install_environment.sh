#!/bin/bash

#console colors
. ./colors.sh

#MidnightCommander
. ./midnightCommander.sh

#PHP
. ./php.sh

#Composer
. ./composer.sh

#Git
. ./git.sh

#MySQL 
. ./mysql.sh

#Nginx
. ./nginx.sh

#memcached
. ./memcached.sh

#opensearch
. ./opensearch.sh

#dashboards
. ./dashboards.sh

#munin
. ./munin.sh

#rabbitmq
. ./rabbitmq.sh

echo "What do you wish to install?"
PS3="Select operation: "
select yn in MidnightCommander PHP Composer Git MySQL NGINX Memcached Opensearch Opensearch-Dashboards Munin RabbitMQ Exit; do
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
        Exit ) exit;;
    esac
done
