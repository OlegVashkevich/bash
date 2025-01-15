# WebDevEnv
- [en](#content)
- [ru](#содержание)
---
## Content
- [Description](#description)
- [Download](#download)
- [Installation Environment for Debian(12)](#installation-environment-for-debian12)
    - [New Menu Items](#new-menu-items)
- [Environment Settings and Service Management for Debian(12)](#environment-settings-and-service-management-for-debian12)
- [Debug](#debug)

## Description

About once a year, I find myself needing to set up an environment for web development under VDS/VPS or WSL, and each time, the knowledge gained previously is forgotten. As a result, during the last setup for WSL, I wanted to systematize the process and create a toolset. This led to creating this set of scripts.

## Download

Download
```bash
sudo apt install curl wget -y
curl -s -L https://github.com/OlegVashkevich/webdevenv/archive/refs/heads/master.tar.gz | tar -xz && mv webdevenv-master webdevenv && cd webdevenv
```

## Installation Environment for Debian(12)

Run
```bash
sudo bash install.sh
```
At this moment, it allows you to choose from the following:

- [Midnight Commander](install/midnightcommander.sh)
- [PHP(8.3+fpm)](install/php.sh)
- [Composer](install/composer.sh)
- [Git](install/git.sh)
- [MySQL](install/mysql.sh)
- [NGINX](install/nginx.sh)
- [memcached](install/memcached.sh)
- [opensearch](install/opensearch.sh)
- [opensearch-dashboards](install/dashboards.sh)
- [manticore](install/manticore.sh)
- [Munin](install/munin.sh)
- [rabbitmq(+erlang)](install/rabbitmq.sh)
- [minio](install/minio.sh)
- [redis](install/redis.sh)

### New Menu Items

To create a new menu item, you need to:
 - Add a file named {filename} in the install directory
 - In the file, there should be a function with the name install_{filename}
 Example:
 ```bash
 install_filename () {
    echo "Start install Filename"
    read -p "$(echo -e $Green"Finish install Filename"$Color_Off. Press enter to continue)"
 }
 ```

 ## Environment Settings and Service Management for Debian(12)

Allows you to:
- Add or delete a new site in the Nginx (php-fpm) configuration
- Manage services

Run
```bash
sudo bash service.sh
```

 ## Debug

 If your script needs debugging  - just include `. ./common/debug.sh` under the line `#!/bin/bash`

[up](#webdevenv)

---
## Содержание
- [Описание](#описание)
- [Загрузка](#загрузка)
- [Установка окружения для Debian(12)](#установка-окружения-для-debian12)
    - [Новые пункты меню](#установка-окружения-для-debian12)
- [Настройки окружения и управление сервисами для Debian(12)](#настройки-окружения-и-управление-сервисами-для-debian12)
- [Отладка](#отладка)
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
- [manticore](install/manticore.sh)
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

 ## Отладка

 Если ваш скрипт нуждается в отладке - просто подключите  `. ./common/debug.sh` под строкой `#!/bin/bash`

[вверх](#webdevenv)
