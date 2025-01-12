#Redis
install_redis () {
    apt install redis-server -y
    systemctl status redis --no-pager
    redis-cli -v
    read -p "$(echo -e $Green"Finish install Redis"$Color_Off. Press enter to continue)"
}