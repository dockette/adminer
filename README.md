# Adminer / Adminer Editor

[![Docker Stars](https://img.shields.io/docker/stars/dockette/adminer.svg?style=flat)](https://hub.docker.com/r/dockette/adminer/)
[![Docker Pulls](https://img.shields.io/docker/pulls/dockette/adminer.svg?style=flat)](https://hub.docker.com/r/dockette/adminer/)

## Discussion / Help

[![Join the chat](https://img.shields.io/gitter/room/dockette/dockette.svg?style=flat-square)](https://gitter.im/dockette/dockette?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Adminer

> Database management in a single PHP file.

You should take a look to the official github profile (https://github.com/vrana/adminer).

![Adminer](https://rawgit.com/dockette/adminer/master/.docs/assets/adminer.png)

### Prolog

There are few variants of this adminer image, mostly based on Alpine Linux:

- full (mysql, pgsql, sqlite, mongo)
- mysql (only)
- pgsql (only)
- mongo (only)

### Usage

```sh
docker run \
    --rm
    -p 8000:80
    dockette/adminer:full
```

By default container is running with `MEMORY=256M` (memory_limit) and `UPLOAD=2048M` (upload_max_filesize, post_max_size). You can override it.

```sh
docker run \
    --rm
    -p 8000:80
    -e MEMORY=512M
    -e UPLOAD=4096M
    dockette/adminer:full
```

### Tags

| Image                        | Technologies                          | Size | Docker Hub                                              |
|------------------------------|---------------------------------------|------|---------------------------------------------------------|
| dockette/adminer             | MySQL / PostgreSQL / MongoDB / Sqlite | 12mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:full        | MySQL / PostgreSQL / MongoDB / Sqlite | 12mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:mysql       | MySQL                                 | 9mb  | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:pgsql       | PostgreSQL                            | 8mb  | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:mongo       | MongoDB                               | 9mb  | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:full-php5   | MySQL / PostgreSQL / MongoDB / Sqlite | 10mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:mysql-php5  | MySQL                                 | 9mb  | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:pgsql-php5  | PostgreSQL                            | 10mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:mongo-php5  | MongoDB                               | 10mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |

## Adminer DG

> Customization for the best database management tool written in PHP, Adminer

You should take a look to the official github profile (https://github.com/dg/adminer-custom).

![Adminer DG](https://rawgit.com/dockette/adminer/master/.docs/assets/adminer-dg.png)

### Usage

```sh
docker run \
    --rm
    -p 8000:80
    dockette/adminer:dg
```

### Tags

| Image                        | Technologies                          | Size | Docker Hub                                              |
|------------------------------|---------------------------------------|------|---------------------------------------------------------|
| dockette/adminer:dg          | MySQL / PostgreSQL / MongoDB / Sqlite | 16mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
