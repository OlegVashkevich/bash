# Bash cкрипты

## Настройки окружения для WSL Debian(12)
скачиваем
```bash
curl -s -L https://github.com/OlegVashkevich/bash/archive/refs/heads/master.tar.gz | tar -xz && mv bash-master/* . && rm -rf bash-master
```
запускаем
```bash
sudo bash install_environment.sh
```
устанавливает на выбор 

- [Midnight Commander](install/midnightcommander.sh)
- [PHP(8.3+fpm)](install/php.sh)
- [Composer](install/composer.sh)
- [Git](install/git.sh)
- [MySQL](install/mysql.sh)
- [NGINX](install/nginx.sh)
- [memcached](install/memcached.sh)
- [opensearch(+jdk)](install/opensearch.sh)
- [opensearch-dashboards](install/dashboards.sh)
- [Munin](install/munin.sh)
- [rabbitmq(+erlang)](install/rabbitmq.sh)
- [minio](install/minio.sh)
- [redis](install/redis.sh)


TODO: разобраться у opensearch с плагином security (получилось завести только с его удалением)

TODO: Скрипт для добавления нового проекта по какркасу + настройка nginx