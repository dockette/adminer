# Adminer

[![Docker Stars](https://img.shields.io/docker/stars/dockette/adminer.svg?style=flat)](https://hub.docker.com/r/dockette/adminer/)
[![Docker Pulls](https://img.shields.io/docker/pulls/dockette/adminer.svg?style=flat)](https://hub.docker.com/r/dockette/adminer/)

## Image

### Extensions

- mysql
- pgsql
- sqlite
- mongo

## Usage

```sh
docker run \
    --rm
    -p 80:80
    dockette/adminer
```

## Variants

| Image                        | Technologies                          | Size | Docker Hub                                              |
|------------------------------|---------------------------------------|------|---------------------------------------------------------|
| dockette/adminer             | MySQL / PostgreSQL / MongoDB / Sqlite | 12mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:full-php7   | MySQL/ PostgreSQL / MongoDB / Sqlite  | 12mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:mysql-php7  | MySQL                                 | 9mb  | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:pgsql-php7  | PostgreSQL                            | 8mb  | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:mongo-php7  | MongoDB                               | 9mb  | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:full-php5   | MySQL/ PostgreSQL / MongoDB / Sqlite  | 10mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:mysql-php5  | MySQL                                 | 9mb  | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:pgsql-php5  | PostgreSQL                            | 10mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:mongo-php5  | MongoDB                               | 10mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:debian-php5 | MySQL/ PostgreSQL / MongoDB / Sqlite  | 70mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:debian-php7 | MySQL / PostgreSQL / MongoDB / Sqlite | 87mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
