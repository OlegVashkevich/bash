#dashboards
install_dashboards () {
    echo "deb https://artifacts.opensearch.org/releases/bundle/opensearch-dashboards/2.x/apt stable main" | tee -a /etc/apt/sources.list.d/opensearch-2.x.list
    apt update
    apt install opensearch-dashboards
    systemctl daemon-reload
    systemctl enable opensearch-dashboards
    systemctl restart opensearch-dashboards
    systemctl status opensearch-dashboards --no-pager
    read -p "$(echo -e $Green"Finish install Opensearch-Dashboards"$Color_Off. Open http://localhost:5601. Press enter to continue)"
}