#MySQL 
install_mysql () {
    wget  https://dev.mysql.com/get/mysql-apt-config_0.8.30-1_all.deb
    apt install ./mysql-apt-config_*_all.deb -y
    apt update
    apt-get install mysql-server
    read -p "$(echo -e $Green"Finish install MySQL"$Color_Off. Press enter to continue)"
}