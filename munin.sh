#munin
install_munin () {
    apt update && sudo apt upgrade -y
    apt install munin munin-node munin-plugins-extra -y
    htpasswd -c /etc/munin/munin-htpasswd admin
    systemctl restart munin-node
    systemctl status munin-node --no-pager
cat >> /etc/nginx/sites-available/munin.dev.local <<EOF
server {
listen 80;
server_name munin.dev.local;
root /var/cache/munin/www;
index index.html;
}
EOF
    ln -s /etc/nginx/sites-available/munin.dev.local /etc/nginx/sites-enabled/munin.dev.local
    nginx -t
    nginx -s reload
    read -p "$(echo -e $Green"Finish install Munin"$Color_Off. You can open http://munin.dev.local/. Press enter to continue)"
}