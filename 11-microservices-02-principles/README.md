
# Домашнее задание к занятию «Микросервисы: принципы»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

## Задача 1: API Gateway 

> Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.
> 
> Решение должно соответствовать следующим требованиям:
> - маршрутизация запросов к нужному сервису на основе конфигурации,
> - возможность проверки аутентификационной информации в запросах,
> - обеспечение терминации HTTPS.
> 
> Обоснуйте свой выбор.

### Ответ:

| ПО                     | Маршрутизация | Аутентификация | Терминация HTTPS | Модель распространения                                      |
|------------------------|---------------|----------------|------------------|-------------------------------------------------------------|
| Kong                   | +             | +              | +                | Open Source, Apache 2.0                                     |
| Tyk.io                 | +             | +              | +                | Open Source, MPL                                            |
| Apache APISIX          | +             | +              | +                | Open Source, Apache 2.0                                     |
| APIGee                 | +             | +              | +                | Платно                                                      |
| Amazon AWS API Gateway | +             | +              | -                | Платно                                                      |
| Azure API Gateway      | +             | +              | +                | Платно                                                      |
| NGINX                  | +             | +              | +                | Open Source, но есть платная версия NGINX Plus              |
| KrakenD                | +             | +              | +                | Open Source (для Community Edition), но есть платная версии |

Как видно из сравнительной таблицы, практически все решения применимы в нашем случае. Следовательно, нужно ориентироваться на модель распространения и условную "простоту" и надежность в использовании.

Можно выбрать NGINX, но в Open Source edition отсутствуют некоторые важные функции (например, Active health checks), 
а также он не подгружает изменения конфигурации динамически, что может негативно сказаться при эксплуатации в проде.

Также есть очень популярный Kong, основанный на NGINX, но для его работы дополнительно необходима внешняя БД PostgreSQL/Cassandra, а также при большом количестве маршрутов проседает в производительности.

Я бы предложил использовать Kong или Apache APISIX, разработчики которого старались [устранить](https://api7.ai/blog/why-choose-apisix-instead-of-nginx-or-kong) недостатки NGINX и Kong.

---

## Задача 2: Брокер сообщений

> Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.
> 
> Решение должно соответствовать следующим требованиям:
> - поддержка кластеризации для обеспечения надёжности,
> - хранение сообщений на диске в процессе доставки,
> - высокая скорость работы,
> - поддержка различных форматов сообщений,
> - разделение прав доступа к различным потокам сообщений,
> - простота эксплуатации.
> 
> Обоснуйте свой выбор.

### Ответ:

| ПО                      | Кластеризация | Хранение на диске | Скорость | Поддержка форматов | Права доступа | Простота |
|:------------------------|:-------------:|:-----------------:|:--------:|:------------------:|:-------------:|:--------:|
| Kafka                   |       +       |         +         |    +     |         -          |       +       |    -     |
| RabbitMQ                |       +       |         +         |   +/-    |         +          |       +       |    +     |
| ZeroMQ                  |       +       |         +         |    +     |         +          |       +       |    -     |
| ActiveMQ                |       +       |         +         |    -     |         +          |       +       |    +     |
| NATS                    |       +       |         +         |    +     |         -          |       +       |    +     |
| Redis (pub,sub)         |       +       |         -         |    +     |         -          |       -       |    +     |

Kafka - замечательное решение, но для работы нужен кластер из 3х нод в KRaft для репликации
Из решений , соответсвующих всем требовням, я бы предпочёл использовать самое популярное решения - RabbitMQ, для которого легче найти подходящих специалистов и имеется много документации и интернет-ресурсов.

## Задача 3: API Gateway * (необязательная)

> ### Есть три сервиса:
> 
> **minio**
> - хранит загруженные файлы в бакете images,
> - S3 протокол,
> 
> **uploader**
> - принимает файл, если картинка сжимает и загружает его в minio,
> - POST /v1/upload,
> 
> **security**
> - регистрация пользователя POST /v1/user,
> - получение информации о пользователе GET /v1/user,
> - логин пользователя POST /v1/token,
> - проверка токена GET /v1/token/validation.
> 
> ### Необходимо воспользоваться любым балансировщиком и сделать API Gateway:
> 
> **POST /v1/register**
> 1. Анонимный доступ.
> 2. Запрос направляется в сервис security POST /v1/user.
> 
> **POST /v1/token**
> 1. Анонимный доступ.
> 2. Запрос направляется в сервис security POST /v1/token.
> 
> **GET /v1/user**
> 1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
> 2. Запрос направляется в сервис security GET /v1/user.
> 
> **POST /v1/upload**
> 1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
> 2. Запрос направляется в сервис uploader POST /v1/upload.
> 
> **GET /v1/user/{image}**
> 1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
> 2. Запрос направляется в сервис minio GET /images/{image}.
> 
> ### Ожидаемый результат
> 
> Результатом выполнения задачи должен быть docker compose файл, запустив который можно локально выполнить следующие команды с успешным результатом.
> Предполагается, что для реализации API Gateway будет написан конфиг для Nginx или другого балансировщика нагрузки, который будет запущен как сервис через docker-compose и будет обеспечивать балансировку и проверку аутентификации входящих запросов.
> Авторизация
> curl -X POST -H 'Content-Type: application/json' -d '{"login":"bob", "password":"qwe123"}' http://localhost/token
> 
> **Загрузка файла**
> 
> curl -X POST -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I' -H 'Content-Type: octet/stream' --data-binary @yourfilename.jpg http://localhost/upload
> 
> **Получение файла**
> curl -X GET http://localhost/images/4e6df220-295e-4231-82bc-45e4b1484430.jpg

---

### Ответ:

Для достижения результата:
1) Актуализировал [src/security/requirements.txt](src/security/requirements.txt) с версиями библиотек, т.к. при сборке были ошибки
2) В [src/.env](src/.env) изменил bucket на `images`
3) В [docker-compose.yaml](src/docker-compose.yaml) поправил в createbuckets установку политик для `images` storage, т.к. `mc` cli изменился в новых версиях
4) Написал конфигурацию [nginx.conf](src/gateway/nginx.conf)


<details>
    <summary>Запуск `docker compose`</summary>

    nedorezov@GARRO:/mnt/e/netology-devops-homeworks/11-microservices-02-principles/src$ docker compose up --build
    [+] Building 2.6s (22/22) FINISHED                                                                                                                                                                                                                                                                                                                                   docker:default
     => [uploader internal] load build definition from Dockerfile                                                                                                                                                                                                                                                                                                                  0.0s
     => => transferring dockerfile: 144B                                                                                                                                                                                                                                                                                                                                           0.0s
     => [security internal] load build definition from Dockerfile                                                                                                                                                                                                                                                                                                                  0.0s
     => => transferring dockerfile: 180B                                                                                                                                                                                                                                                                                                                                           0.0s
     => [uploader internal] load metadata for docker.io/library/node:alpine                                                                                                                                                                                                                                                                                                        2.5s
     => [security internal] load metadata for docker.io/library/python:3.9-alpine                                                                                                                                                                                                                                                                                                  1.7s
     => [security auth] library/python:pull token for registry-1.docker.io                                                                                                                                                                                                                                                                                                         0.0s
     => [uploader auth] library/node:pull token for registry-1.docker.io                                                                                                                                                                                                                                                                                                           0.0s
     => [security internal] load .dockerignore                                                                                                                                                                                                                                                                                                                                     0.0s
     => => transferring context: 2B                                                                                                                                                                                                                                                                                                                                                0.0s
     => [security 1/5] FROM docker.io/library/python:3.9-alpine@sha256:ce83ae657ad10635ea43ecd5efb6ca50bec62183148e37fba075e18a8a34868f                                                                                                                                                                                                                                            0.0s
     => [security internal] load build context                                                                                                                                                                                                                                                                                                                                     0.0s
     => => transferring context: 93B                                                                                                                                                                                                                                                                                                                                               0.0s
     => CACHED [security 2/5] WORKDIR /app                                                                                                                                                                                                                                                                                                                                         0.0s
     => CACHED [security 3/5] COPY requirements.txt .                                                                                                                                                                                                                                                                                                                              0.0s
     => CACHED [security 4/5] RUN pip install -r requirements.txt                                                                                                                                                                                                                                                                                                                  0.0s
     => CACHED [security 5/5] COPY src ./                                                                                                                                                                                                                                                                                                                                          0.0s
     => [security] exporting to image                                                                                                                                                                                                                                                                                                                                              0.0s
     => => exporting layers                                                                                                                                                                                                                                                                                                                                                        0.0s
     => => writing image sha256:e260dbeb8c8798dafe1d032ee0ab87639a448d43d31a6eee3f4e2170f600e860                                                                                                                                                                                                                                                                                   0.0s
     => => naming to docker.io/library/src-security                                                                                                                                                                                                                                                                                                                                0.0s
     => [uploader internal] load .dockerignore                                                                                                                                                                                                                                                                                                                                     0.0s
     => => transferring context: 52B                                                                                                                                                                                                                                                                                                                                               0.0s
     => [uploader 1/5] FROM docker.io/library/node:alpine@sha256:7bfef1d72befbb72b0894a3e4503edbdc0441058b4d091325143338cbf54cff8                                                                                                                                                                                                                                                  0.0s
     => [uploader internal] load build context                                                                                                                                                                                                                                                                                                                                     0.0s
     => => transferring context: 128B                                                                                                                                                                                                                                                                                                                                              0.0s
     => CACHED [uploader 2/5] WORKDIR /app                                                                                                                                                                                                                                                                                                                                         0.0s
     => CACHED [uploader 3/5] COPY package*.json ./                                                                                                                                                                                                                                                                                                                                0.0s
     => CACHED [uploader 4/5] RUN npm install                                                                                                                                                                                                                                                                                                                                      0.0s 
     => CACHED [uploader 5/5] COPY src ./                                                                                                                                                                                                                                                                                                                                          0.0s 
     => [uploader] exporting to image                                                                                                                                                                                                                                                                                                                                              0.0s 
     => => exporting layers                                                                                                                                                                                                                                                                                                                                                        0.0s 
     => => writing image sha256:d5de317d34698e617833ef18a86b794af1dbeeaa8d3ece69a39955be5a020a29                                                                                                                                                                                                                                                                                   0.0s 
     => => naming to docker.io/library/src-uploader                                                                                                                                                                                                                                                                                                                                0.0s 
    [+] Running 5/0
     ✔ Container src-storage-1        Created                                                                                                                                                                                                                                                                                                                                      0.0s 
     ✔ Container src-createbuckets-1  Created                                                                                                                                                                                                                                                                                                                                      0.0s 
     ✔ Container src-uploader-1       Created                                                                                                                                                                                                                                                                                                                                      0.0s 
     ✔ Container src-security-1       Created                                                                                                                                                                                                                                                                                                                                      0.0s 
     ✔ Container src-gateway-1        Created                                                                                                                                                                                                                                                                                                                                      0.0s 
    Attaching to src-createbuckets-1, src-gateway-1, src-security-1, src-storage-1, src-uploader-1
    src-security-1       |  * Serving Flask app 'server'
    src-security-1       |  * Debug mode: off
    src-security-1       | WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
    src-security-1       |  * Running on all addresses (0.0.0.0)
    src-security-1       |  * Running on http://127.0.0.1:3000
    src-security-1       |  * Running on http://172.22.0.2:3000
    src-security-1       | Press CTRL+C to quit
    src-storage-1        | MinIO Object Storage Server
    src-storage-1        | Copyright: 2015-2024 MinIO, Inc.
    src-storage-1        | License: GNU AGPLv3 <https://www.gnu.org/licenses/agpl-3.0.html>
    src-storage-1        | Version: RELEASE.2024-03-07T00-43-48Z (go1.21.8 linux/amd64)
    src-storage-1        |
    src-storage-1        | Status:         1 Online, 0 Offline.
    src-storage-1        | S3-API: http://172.22.0.3:9000  http://127.0.0.1:9000
    src-storage-1        | Console: http://172.22.0.3:33583 http://127.0.0.1:33583
    src-storage-1        |
    src-storage-1        | Documentation: https://min.io/docs/minio/linux/index.html
    src-storage-1        | Warning: The standard parity is set to 0. This can lead to data loss.
    src-createbuckets-1  | Added `storage` successfully.
    src-createbuckets-1  | Bucket created successfully `storage/images`.
    src-createbuckets-1  | Access permission for `storage/images` is set to `download`
    src-uploader-1       | S3: storage:9000 images
    src-uploader-1       | Listening on port 3000
    src-createbuckets-1 exited with code 0
    src-gateway-1        | /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
    src-gateway-1        | /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
    src-gateway-1        | /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
    src-gateway-1        | 10-listen-on-ipv6-by-default.sh: info: IPv6 listen already enabled
    src-gateway-1        | /docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
    src-gateway-1        | /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
    src-gateway-1        | /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
    src-gateway-1        | /docker-entrypoint.sh: Configuration complete; ready for start up
    src-uploader-1       | (node:1) [DEP0152] DeprecationWarning: Custom PerformanceEntry accessors are deprecated. Please use the detail property.
    src-uploader-1       | (Use `node --trace-deprecation ...` to show where the warning was created)
    src-security-1       | 172.22.0.6 - - [08/Mar/2024 13:00:30] "POST /v1/token HTTP/1.0" 200 -
    src-gateway-1        | {"time_local":"08/Mar/2024:13:00:30 +0000","remote_addr":"172.22.0.1","remote_user":"","request":"POST /v1/token HTTP/1.1","status": "200","body_bytes_sent":"99","request_time":"0.010","http_referrer":"","http_user_agent":"curl/8.4.0","http_x_forwarded_for":"","upstream_connect_time":"0.001","upstream_header_time":"0.011","upstream_response_time":"0.011"}
    src-security-1       | 172.22.0.6 - - [08/Mar/2024 13:00:37] "GET /v1/token/validation HTTP/1.0" 200 -
    src-gateway-1        | 2024/03/08 13:00:37 [warn] 23#23: *3 a client request body is buffered to a temporary file /var/cache/nginx/client_temp/0000000001 while sending to client, client: 172.22.0.1, server: , request: "POST /v1/upload HTTP/1.1", host: "localhost"
    src-uploader-1       | Detected file type: image/jpeg
    src-uploader-1       | Saved file in images: 572738df-2cad-487c-a38e-6823d59e46cd.jpg
    src-gateway-1        | {"time_local":"08/Mar/2024:13:00:38 +0000","remote_addr":"172.22.0.1","remote_user":"","request":"POST /v1/upload HTTP/1.1","status": "200","body_bytes_sent":"55","request_time":"0.044","http_referrer":"","http_user_agent":"curl/8.4.0","http_x_forwarded_for":"","upstream_connect_time":"0.001","upstream_header_time":"0.042","upstream_response_time":"0.042"}
    src-security-1       | 172.22.0.6 - - [08/Mar/2024 13:01:00] "GET /v1/token/validation HTTP/1.0" 200 -
    src-gateway-1        | {"time_local":"08/Mar/2024:13:01:00 +0000","remote_addr":"172.22.0.1","remote_user":"","request":"GET /v1/user/572738df-2cad-487c-a38e-6823d59e46cd.jpg HTTP/1.1","status": "200","body_bytes_sent":"146496","request_time":"0.004","http_referrer":"","http_user_agent":"curl/8.4.0","http_x_forwarded_for":"","upstream_connect_time":"0.000","upstream_header_time":"0.001","upstream_response_time":"0.002"}
</details>

Проверил работу загрузки и выгрузки файла с аутентификацией:
![](img/01.png)

#### [Дополнительные материалы: как запускать, как тестировать, как проверить](https://github.com/netology-code/devkub-homeworks/tree/main/11-microservices-02-principles)

---
