
# docker-compose для MoscowLAN 2026

Я не хочу настраивать снова серваки руками как в 2024.

В основу взяты  [melkortf/tf2-competitive и melkortf/tf2-mge](https://github.com/melkortf/tf2-servers/)

## Сервера

- 3 игровых сервера под турнир;
- 1 MGE сервер для разминок;
- Локальный FastDL;
- Сервер Mumble под резерв.


## Установка

- Подготовка:

  Заполняем `.env` своими значениями.

  Для `DOWNLOAD_URL` указываем IP-адрес машины.

  В `docker-compose.yaml` тоже не забываем указать IP-адрес машины: `http://changeme:8080/maps`

- Кладем карты в `./fastdl/maps`

- Запускаем навайбкоженный `bz2-create.sh` **для клиентов** (сервера тянут карты с фастдл без сжатия)

## Запускаем:

```bash
docker compose up --build -d
```

### глхф.
