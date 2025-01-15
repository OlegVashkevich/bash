#!/bin/bash

#. ./common/debug.sh

#console colors
. ./common/colors.sh

showMenu(){
    echo "--------------------------------"
    echo "    Service your environment   "
    echo "--------------------------------"
    echo "[1] add site"
    echo "[2] remove site"
    echo "--------------------------------"
    echo "           services            "
    echo "--------------------------------"
    echo "[3] check all services"
    echo "[4] select service"
    echo "--------------------------------"
    echo "[0] exit"
    echo "--------------------------------"

    read -p "Please Select A Number: " mc
    return $mc
}

service(){
    echo "you choose $1"
    systemctl status $1 --no-pager
    echo "What you want to do with $1"
    PS3="Select number: "
    arractions=(enable disable start stop status)
    select ym in "exit" "${arractions[@]}" 
    do
        if [ "$ym" == "exit" ]
        then break;
        elif [ "$ym" ]
        then action $1 $ym;
        fi
    done
    read -p "$(echo -e $Green"Press enter to show menu"$Color_Off)"
}
action(){
    if [[ "$2" == "enable" ]]; then
        systemctl enable $1
        echo "$1 enabled"
    elif [[ "$2" == "disable" ]]; then
        systemctl disable $1
        echo "$1 disabled"
    elif [[ "$2" == "start" ]]; then
        systemctl start $1
        echo "$1 started"
    elif [[ "$2" == "stop" ]]; then
        systemctl stop $1
        echo "$1 stopped"
    elif [[ "$2" == "status" ]]; then
        systemctl status $1
    fi
    read -p "$(echo -e $Green"Press enter to show menu"$Color_Off)"
}

create_index () {
    sudo -u $3 mkdir -p $1
cat > $1/index.php <<EOF
<?php
    echo "Hello $2";
EOF
}

add_site(){
    [ $SUDO_USER ] && user=$SUDO_USER || user=`whoami`
    read -p "Enter server_name ex.:[dev.local]: " name
    name=${name:-dev.local}
    read -p "Enter root_path ex.:[/home/$user/$name/public]: " path
    path=${path:-/home/$user/$name/public}
cat > /etc/nginx/sites-available/$name <<EOF
server {
    listen 80;
    listen [::]:80;
    server_name $name;
    root $path;

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
    ln -s /etc/nginx/sites-available/$name /etc/nginx/sites-enabled/$name
    nginx -t
    nginx -s reload
    echo "site added  to nginx"
    echo "Do you want create $path/index.php?"
    PS3="Select operation: "
    select yn in Yes No; do
        case $yn in
            Yes ) create_index $path $name $user;break;;
            No ) break;;
        esac
    done
}

while [[ "$m" != "0" ]]
do
    if [[ "$m" == "1" ]]; then
        add_site
        read -p "$(echo -e $Green"Press enter to show menu"$Color_Off)"
    elif [[ "$m" == "2" ]]; then
        #get all sites
        arrsites=( $(ls /etc/nginx/sites-available/) )
        echo "Choose one of sites you want remove"
        PS3="Select number: "
        select ys in "exit" "${arrsites[@]}" 
        do
            if [ "$ys" == "exit" ]
            then break;
            elif [ "$ys" ]
            then 
                echo $ys;
                rm -f /etc/nginx/sites-available/$ys
                rm -f /etc/nginx/sites-enabled/$ys
                echo "site $ys removed from nginx"
            fi
        done
        read -p "$(echo -e $Green"Press enter to show menu"$Color_Off)"
    elif [[ "$m" == "3" ]]; then
        systemctl list-unit-files --type service --state enabled,disabled | grep -ve "systemd" -ve "getty"  -ve "@" 
        read -p "$(echo -e $Green"Press enter to show menu"$Color_Off)"
    elif [[ "$m" == "4" ]]; then
        #get all services
        arrservices=($(systemctl list-unit-files --type service --state enabled,disabled --plain --no-legend --no-page | grep -ve "systemd" -ve "getty"  -ve "@" | sed 's/ \{1,\}/,/g' | awk -v g="$Green" -v r="$Red" -v n="$Color_Off" -F'.service' '{if ($2~/enabled,enabled/) {printf "%s%s%s\n", g, $1, n}  else {printf "%s%s%s\n", r, $1, n}}'))
        #arrservices+=($(systemctl list-unit-files --type service --state disabled --plain --no-legend --no-page | grep -ve "systemd" -ve "getty"  -ve "@"  | awk -v r="$Red" -v n="$Color_Off" -F'.service' '{printf "%s%s%s\n", r, $1$2, n}'))
        echo -e "Choose one of service ($Green enabled $Color_Off / $Red disabled $Color_Off)"
        PS3="Select number: "
        select yn in "exit" "${arrservices[@]}" 
        do
            if [ "$yn" == "exit" ]
            then break;
            elif [ "$yn" ]
            then 
                srv=$(echo $yn | sed -e 's/\x1b\[[0-9;]*m//g')
                service $srv
            fi
        done
        read -p "$(echo -e $Green"Press enter to show menu"$Color_Off)"
    fi
    showMenu
    m=$?
done

exit 0;