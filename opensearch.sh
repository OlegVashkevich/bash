#opensearch
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
#plugins.security.disabled: true
EOF
    curl -X GET "http://localhost:9200"
    read -p "$(echo -e $Green"Finish install Opensearch"$Color_Off. Press enter to continue)"
}