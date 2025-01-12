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
cat > /etc/nginx/sites-available/dev.local <<EOF
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
