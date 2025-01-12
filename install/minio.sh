#MinIO
install_minio () {
    wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio_20241218131544.0.0_amd64.deb -O minio.deb
    dpkg -i minio.deb
    rm -f minio.deb
    mkdir /mnt/minio
    groupadd -r minio-user
    useradd -M -r -g minio-user minio-user
    chown minio-user:minio-user /mnt/minio
    read -p "Set username[minioadmin]: " name
    name=${name:-minioadmin}
    read -p "Set password [minioadmin]: " pass
    pass=${pass:-minioadmin}
cat > /etc/default/minio <<EOF
MINIO_ROOT_USER=$name
MINIO_ROOT_PASSWORD=$pass
MINIO_VOLUMES="/mnt/minio"
MINIO_OPTS="--console-address :9001"
EOF
    systemctl enable minio.service
    systemctl restart minio.service
    systemctl status minio.service --no-pager
    read -p "$(echo -e $Green"Finish install MinIO"$Color_Off. Press enter to continue)"
}