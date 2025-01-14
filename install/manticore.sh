#manticore
install_manticore () {
    wget https://repo.manticoresearch.com/manticore-repo.noarch.deb -O manticore.deb
    dpkg -i manticore.deb
    apt update -y
    apt install manticore manticore-extra -y
    rm -f manticore.deb
    systemctl enable manticore
    systemctl start manticore
    systemctl status manticore --no-pager
    curl -s "http://localhost:9308"
    read -p "$(echo -e $Green"Finish install Manticore"$Color_Off. Press enter to continue)"
}