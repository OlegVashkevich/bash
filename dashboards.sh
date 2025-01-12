#dashboards
install_dashboards () {
    apt update && sudo apt upgrade -y
    wget https://artifacts.opensearch.org/releases/bundle/opensearch-dashboards/2.18.0/opensearch-dashboards-2.18.0-linux-x64.deb
    dpkg -i opensearch-dashboards-2.18.0-linux-x64.deb
cat >> /etc/opensearch-dashboards/opensearch_dashboards.yml <<EOF
server.host: 0.0.0.0
EOF
    rm -f opensearch-dashboards-2.18.0-linux-x64.deb
    systemctl daemon-reload
    systemctl enable opensearch-dashboards
    systemctl start opensearch-dashboards
    systemctl status opensearch-dashboards
    read -p "$(echo -e $Green"Finish install Opensearch-Dashboards"$Color_Off. Press enter to continue)"
}