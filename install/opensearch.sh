#opensearch
install_opensearch () {
    apt -y install curl lsb-release gnupg2 ca-certificates
    curl -fsSL https://artifacts.opensearch.org/publickeys/opensearch.pgp| gpg --dearmor -o /etc/apt/trusted.gpg.d/opensearch.gpg
    echo "deb https://artifacts.opensearch.org/releases/bundle/opensearch/2.x/apt stable main" | tee /etc/apt/sources.list.d/opensearch-2.x.list
    apt update -y
    read -p "OPENSEARCH_INITIAL_ADMIN_PASSWORD(minimum 8 character password and must contain at least one uppercase letter, one lowercase letter, one digit, and one special character that is strong)[Your123_Something@Secure]: " pass
    pass=${pass:-Your123_Something@Secure}
    env OPENSEARCH_INITIAL_ADMIN_PASSWORD=$pass apt install opensearch
    systemctl daemon-reload
    systemctl restart opensearch
    systemctl status opensearch --no-pager
    curl -X GET https://localhost:9200 -u "admin:$pass" --insecure
    read -p "$(echo -e $Green"Finish install Opensearch"$Color_Off. Press enter to continue)"
}