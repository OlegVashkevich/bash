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