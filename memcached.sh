#memcached
install_memcached () {
    apt install memcached libmemcached-tools
    memcached --version
    systemctl enable memcached
    systemctl start memcached
    systemctl status memcached
    ss -plunt | grep memcached
    read -p "$(echo -e $Green"Finish install Memcached"$Color_Off. Press enter to continue)"
}