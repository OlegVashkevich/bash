#MySQL 
install_mysql () {
    #check last packeges here https://dev.mysql.com/downloads/repo/apt/
    wget  https://dev.mysql.com/get/mysql-apt-config_0.8.33-1_all.deb -O mysql.deb
    apt install mysql.deb -y
    apt update
    apt-get install mysql-server -y
    rm -f mysql.deb
    read -p "$(echo -e $Green"Finish install MySQL"$Color_Off. Press enter to continue)"
}