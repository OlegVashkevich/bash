# Bash cкрипты
скачиваем
```bash
curl -s -L https://github.com/OlegVashkevich/bash/archive/refs/heads/master.tar.gz | tar -xz && mv bash-master/* . && rm -rf bash-master
```

## Установка окружения для WSL Debian(12)
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

### Новые пункты меню
что бы создать новый пункт меню, надо
 - добавить файл c названием {filename} в директорию install
 - в айле должна быть функция с названием install_{filename}
 пример:
 ```bash
 install_filename () {
    echo "Start install Filename"
    read -p "$(echo -e $Green"Finish install Filename"$Color_Off. Press enter to continue)"
 }
 ```

 ## Настройки окружения и управление сервисами для WSL Debian(12)
запускаем
```bash
sudo bash service_environment.sh
```


## TODO
- разобраться у opensearch с плагином security (получилось завести только с его удалением)
- Скрипт для добавления нового проекта по каркасу + настройка nginx(добавить реализацию в service_environment.sh)