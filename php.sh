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