# WebDevEnv
- [Описание](#описание)
- [Загрузка](#загрузка)
- [Установка окружения для Debian(12)](#установка-окружения-для-debian12)
    - [Новые пункты меню](#установка-окружения-для-debian12)
- [Настройки окружения и управление сервисами для Debian(12)](#настройки-окружения-и-управление-сервисами-для-debian12)
## Описание

Примерно раз в год я сталкиваюсь с необходимостью настройки среды для веб-разработки под VDS/VPS или WSL, и каждый раз знания, приобретенные ранее, забываются. В результате, во время последней настройки для WSL, мне захотелось систематизировать процесс и создать набор инструментов. Это привело к созданию данного набора скриптов.

## Загрузка

скачиваем
```bash
sudo apt install curl wget -y
curl -s -L https://github.com/OlegVashkevich/webdevenv/archive/refs/heads/master.tar.gz | tar -xz && mv webdevenv-master webdevenv && cd webdevenv
```

## Установка окружения для Debian(12)

запускаем
```bash
sudo bash install.sh
```
на данный момент позволяет устанавить на выбор 

- [Midnight Commander](install/midnightcommander.sh)
- [PHP(8.3+fpm)](install/php.sh)
- [Composer](install/composer.sh)
- [Git](install/git.sh)
- [MySQL](install/mysql.sh)
- [NGINX](install/nginx.sh)
- [memcached](install/memcached.sh)
- [opensearch](install/opensearch.sh)
- [opensearch-dashboards](install/dashboards.sh)
- [Munin](install/munin.sh)
- [rabbitmq(+erlang)](install/rabbitmq.sh)
- [minio](install/minio.sh)
- [redis](install/redis.sh)

### Новые пункты меню

что бы создать новый пункт меню, надо
 - добавить файл c названием {filename} в директорию install
 - в файле должна быть функция с названием install_{filename}
 пример:
 ```bash
 install_filename () {
    echo "Start install Filename"
    read -p "$(echo -e $Green"Finish install Filename"$Color_Off. Press enter to continue)"
 }
 ```

 ## Настройки окружения и управление сервисами для Debian(12)

позволяет: 
- добавить или удалить новый сайт в конфиг nginx(php-fpm)
- управлять сервисами

запускаем
```bash
sudo bash service.sh
```

