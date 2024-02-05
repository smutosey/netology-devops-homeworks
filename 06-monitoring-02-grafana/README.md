# Домашнее задание к занятию 14 «Средство визуализации Grafana»

## Задание повышенной сложности

**При решении задания 1** не используйте директорию [help](./help) для сборки проекта. Самостоятельно разверните grafana, где в роли источника данных будет выступать prometheus, а сборщиком данных будет node-exporter:

- grafana;
- prometheus-server;
- prometheus node-exporter.

За дополнительными материалами можете обратиться в официальную документацию grafana и prometheus.

В решении к домашнему заданию также приведите все конфигурации, скрипты, манифесты, которые вы 
использовали в процессе решения задания.

**При решении задания 3** вы должны самостоятельно завести удобный для вас канал нотификации, например, Telegram или email, и отправить туда тестовые события.

В решении приведите скриншоты тестовых событий из каналов нотификаций.

## Обязательные задания

### Задание 1

1. Используя директорию [help](./help) внутри этого домашнего задания, запустите связку prometheus-grafana.
2. Зайдите в веб-интерфейс grafana, используя данные для авторизации, указанные в манифесте docker-compose.
3. Подключите поднятый вами prometheus, как источник данных.
4. Решение домашнего задания — скриншот веб-интерфейса grafana со списком подключенных Datasource.

> #### Ответ:
> Создал YC Managed Kubernetes, написал конфигурацию для разворачивания необходимых сервисов:  
> * [Node exporter](k8s/node-exporter.yml)  
> * [Prometheus resources](k8s/prom-resources.yml)  
> * [Grafana resources](k8s/grafana-resources.yml)  
> 
> ![](img/01.png)
> 
> 
> Запустил сервисы, подключился к grafana и настроил datasource:  
> ![](img/02.png)


---

## Задание 2

Изучите самостоятельно ресурсы:

1. [PromQL tutorial for beginners and humans](https://valyala.medium.com/promql-tutorial-for-beginners-9ab455142085).
2. [Understanding Machine CPU usage](https://www.robustperception.io/understanding-machine-cpu-usage).
3. [Introduction to PromQL, the Prometheus query language](https://grafana.com/blog/2020/02/04/introduction-to-promql-the-prometheus-query-language/).

Создайте Dashboard и в ней создайте Panels:

- утилизация CPU для node exporter (в процентах, 100-idle);
- CPULA 1/5/15;
- количество свободной оперативной памяти;
- количество места на файловой системе.

Для решения этого задания приведите promql-запросы для выдачи этих метрик, а также скриншот получившейся Dashboard.

> #### Ответ:
> Создал дашборд с необходимыми метриками:
> ![](img/03.png)
> 
> PormQL запросы:
> - утилизация CPU для node exporter (в процентах, 100-idle);
> ```
> 100 -(avg by (instance) (rate(node_cpu_seconds_total{mode="idle", instance="$instance"}[30s])) * 100)  
> ```
> - CPULA 1/5/15;
> ```
> avg by (instance) (node_load1{instance="$instance"})
> avg by (instance) (node_load5{instance="$instance"})
> avg by (instance) (node_load15{instance="$instance"})
> ```
> - количество свободной оперативной памяти;
> ```
> avg_over_time(node_memory_MemFree_bytes{instance="$instance"}[$__interval])
> ```
> - количество места на файловой системе.
> ```
> 100 - ((node_filesystem_avail_bytes{instance="$instance"} * 100) / node_filesystem_size_bytes{instance="$instance"})
> ```

---


## Задание 3

1. Создайте для каждой Dashboard подходящее правило alert — можно обратиться к первой лекции в блоке «Мониторинг».
2. В качестве решения задания приведите скриншот вашей итоговой Dashboard.

> #### Ответ:
> Для графиков создал алерты по нужным значениям:
> ![](img/05.png)
> 
> На дашборде видны изменения в связи со сработками, видно также статус каждого алерта: 
> ![](img/04.png)
> 
> Также подключил Telegram Contact point как дефолтный, и получил в Telegram оповещение: 
> ![](img/06.png)


---

## Задание 4

1. Сохраните ваш Dashboard. Для этого перейдите в настройки Dashboard, выберите в боковом меню «JSON MODEL». Далее скопируйте отображаемое json-содержимое в отдельный файл и сохраните его.
2. В качестве решения задания приведите листинг этого файла.

> #### Ответ:
> Файл приложен к заданию: [dashboard.json](dashboard.json)

---

---