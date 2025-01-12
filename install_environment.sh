#!/bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

#MidnightCommander
install_mc () {
    apt install mc
    echo "Do you want set mcedit as default editor?"
    PS3="Select operation: "
    select yn in Yes No; do
        case $yn in
            Yes ) install_mcedit;break;;
            No ) break;;
        esac
    done
    read -p "$(echo -e $Green"Finish install MidnightCommander"$Color_Off. Press enter to continue)"
}

install_mcedit () {
    update-alternatives --config editor
    select-editor
    read -p "$(echo -e $Green"Finish install mcedit"$Color_Off. Press enter to continue)"
}

#PHP
install_php () {
    apt update -y && sudo apt upgrade -y
    apt  -y  install  lsb-release  apt-transport-https  ca-certificates
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
    apt update -y
    apt policy php
    apt install -y php
    php -v
    apt install -y php-mysql php-curl php-json php-xml php-mbstring
    apt install -y php8.3-sqlite3 php8.3-fpm
    php -m
    read -p "$(echo -e $Green"Finish install PHP"$Color_Off. Press enter to continue)"
}

#Composer
install_composer () {
    apt install curl
    cd ~
    curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
    HASH=`curl -sS https://composer.github.io/installer.sig`
    php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
    read -p "$(echo -e $Green"Finish install Composer"$Color_Off. Press enter to continue)"
}

#Git
install_git () {
    apt install git
    git --version
    read -p "$(echo -e $Green"Finish install Git"$Color_Off. Press enter to continue)"
}

#MySQL
install_mysql () {
    wget  https://dev.mysql.com/get/mysql-apt-config_0.8.30-1_all.deb
    apt install ./mysql-apt-config_*_all.deb
    apt update
    apt-get install mysql-server
    read -p "$(echo -e $Green"Finish install MySQL"$Color_Off. Press enter to continue)"
}

#Nginx
install_nginx () {
    systemctl stop apache2
    apt-get install nginx
    read -p "Write '127.0.0.1 dev.local' to file C:\Windows\System32\drivers\etc\hosts. Then press enter to continue"
    read -p "Enter user folder name [oleg]: " name
    name=${name:-oleg}
    rm -f /etc/nginx/sites-available/default
    rm -f /etc/nginx/sites-enabled/default
    rm -f /etc/nginx/sites-available/dev.local
    rm -f /etc/nginx/sites-enabled/dev.local
cat >> /etc/nginx/sites-available/dev.local <<EOF
server {
    listen 80;
    listen [::]:80;
    server_name dev.local;
    root /home/$name/dev/public;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    index index.php;

    charset utf-8;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.3-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
EOF
    ln -s /etc/nginx/sites-available/dev.local /etc/nginx/sites-enabled/dev.local
    nginx -t
    nginx -s reload
    var="user $name;"
    #change nginx user(1st line)
    sed -i "1s/.*/$var/" /etc/nginx/nginx.conf
    #change fpm user
    sed -i "s/www-data/$name/g" /etc/php/8.3/fpm/pool.d/www.conf
    service php8.3-fpm restart
    service nginx restart
    read -p "$(echo -e $Green"Finish install NGINX"$Color_Off. You can open http://dev.local/. Press enter to continue)"
}

install_memcached () {
    apt install memcached libmemcached-tools
    memcached --version
    systemctl enable memcached
    systemctl start memcached
    systemctl status memcached
    ss -plunt | grep memcached
    read -p "$(echo -e $Green"Finish install Memcached"$Color_Off. Press enter to continue)"
}

install_opensearch () {
    apt update && sudo apt upgrade -y
    wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
    dpkg -i jdk-21_linux-x64_bin.deb
    java -version
    rm -f jdk-21_linux-x64_bin.deb
    wget https://artifacts.opensearch.org/releases/bundle/opensearch/2.18.0/opensearch-2.18.0-linux-x64.deb
    read -p "OPENSEARCH_INITIAL_ADMIN_PASSWORD(minimum 8 character password and must contain at least one uppercase letter, one lowercase letter, one digit, and one special character that is strong)[Q1w2e3R$]: " pass
    pass=${pass:-Q1w2e3R$}
    env OPENSEARCH_INITIAL_ADMIN_PASSWORD=$pass dpkg -i opensearch-2.18.0-linux-x64.deb
    rm -f opensearch-2.18.0-linux-x64.deb
    systemctl daemon-reload
    systemctl enable opensearch
    systemctl start opensearch
    #systemctl status opensearch
    #nano /etc/sysctl.conf
cat >> /etc/opensearch/opensearch.yml <<EOF
network.host: 0.0.0.0
discovery.type: single-node
plugins.security.disabled: true
EOF
    curl -X GET "http://localhost:9200"
    read -p "$(echo -e $Green"Finish install Opensearch"$Color_Off. Press enter to continue)"
}

install_dashboards () {
    apt update && sudo apt upgrade -y
    wget https://artifacts.opensearch.org/releases/bundle/opensearch-dashboards/2.18.0/opensearch-dashboards-2.18.0-linux-x64.deb
    dpkg -i opensearch-dashboards-2.18.0-linux-x64.deb
cat >> /etc/opensearch-dashboards/opensearch_dashboards.yml <<EOF
server.host: 0.0.0.0
EOF
    rm -f opensearch-dashboards-2.18.0-linux-x64.deb
    systemctl daemon-reload
    systemctl enable opensearch-dashboards
    systemctl start opensearch-dashboards
    systemctl status opensearch-dashboards
    read -p "$(echo -e $Green"Finish install Opensearch-Dashboards"$Color_Off. Press enter to continue)"
}

echo "What do you wish to install?"
PS3="Select operation: "
select yn in MidnightCommander PHP Composer Git MySQL NGINX Memcached Opensearch Opensearch-Dashboards Exit; do
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
        Exit ) exit;;
    esac
done
