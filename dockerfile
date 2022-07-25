# PHP 容器配置

# 从官方基础版本构建
FROM php:7.4-fpm-buster
# 官方版本默认安装扩展:
# Core, ctype, curl
# date, dom
# fileinfo, filter, ftp
# hash
# iconv
# json
# libxml
# mbstring, mysqlnd
# openssl
# pcre, PDO, pdo_sqlite, Phar, posix
# readline, Reflection, session, SimpleXML, sodium, SPL, sqlite3, standard
# tokenizer
# xml, xmlreader, xmlwriter
# zlib

# 1.0.2 增加 bcmath, calendar, exif, gettext, sockets, dba,
# mysqli, pcntl, pdo_mysql, shmop, sysvmsg, sysvsem, sysvshm 扩展
RUN docker-php-ext-install -j$(nproc) bcmath calendar exif gettext \
sockets dba mysqli pcntl pdo_mysql shmop sysvmsg sysvsem sysvshm

# 1.0.3 增加 bz2 扩展, 读写 bzip2（.bz2）压缩文件
RUN apt-get update && \
apt-get install -y --no-install-recommends libbz2-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) bz2

# 1.0.5 增加 GD 扩展. 图像处理
RUN apt-get update && \
apt-get install -y --no-install-recommends libfreetype6-dev libjpeg62-turbo-dev libpng-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
docker-php-ext-install -j$(nproc) gd

# 1.0.6 增加 gmp 扩展, GMP
RUN apt-get update && \
apt-get install -y --no-install-recommends libgmp-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) gmp


# 1.0.19 增加 mcrypt 扩展
RUN apt-get update && \
apt-get install -y --no-install-recommends libmcrypt-dev && \
rm -r /var/lib/apt/lists/* && \
pecl install mcrypt-1.0.1 && \
docker-php-ext-enable mcrypt

# 1.0.22 redis 扩展
RUN pecl install redis-4.0.1 && docker-php-ext-enable redis

# 1.0.22 swoole 扩展
RUN pecl install swoole && docker-php-ext-enable swoole


# 镜像信息
LABEL Author="Machangwen"
LABEL Version="1.0.25-fpm"
LABEL Description="PHP FPM 7.4 镜像. All extensions."
