# Adminer / Adminer Editor / Adminer Custom

> Database management in a single PHP file.

You should take a look to the official github profile (https://github.com/vrana/adminer).

![Adminer](https://rawgit.com/dockette/adminer/master/.docs/assets/adminer.png)

------

[![Docker Stars](https://img.shields.io/docker/stars/dockette/adminer.svg?style=flat)](https://hub.docker.com/r/dockette/adminer/)
[![Docker Pulls](https://img.shields.io/docker/pulls/dockette/adminer.svg?style=flat)](https://hub.docker.com/r/dockette/adminer/)
[![Join the chat](https://img.shields.io/gitter/room/dockette/dockette.svg?style=flat-square)](https://gitter.im/dockette/dockette?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Prologue

There are few variants of this adminer image based on Alpine Linux:

- full (mysql, pgsql, sqlite, mongo)
- mysql (only)
- pgsql (only)
- mongo (only)
- dg (custom)

## Usage

```sh
docker run \
    --rm
    -p 8000:80
    dockette/adminer:dg
```

By default container is running with these settings, you can override it using environment variables.

- `MEMORY=256M` (memory_limit)
- `UPLOAD=2048M` (upload_max_filesize, post_max_size)
- `WORKERS=4` (concurrency)

```sh
docker run \
    --rm
    -p 8000:80
    -e MEMORY=512M
    -e UPLOAD=4096M
    dockette/adminer:dg
```

## Versions

| Image                        | Technologies                          | Size | Docker Hub                                              |
|------------------------------|---------------------------------------|------|---------------------------------------------------------|
| dockette/adminer             | MySQL / PostgreSQL / MongoDB / Sqlite | 12mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:full        | MySQL / PostgreSQL / MongoDB / Sqlite | 12mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:mysql       | MySQL                                 | 9mb  | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:pgsql       | PostgreSQL                            | 8mb  | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:mongo       | MongoDB                               | 9mb  | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:dg          | MySQL / PostgreSQL / MongoDB / Sqlite | 16mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |

### `dockette/adminer:dg`

> Customization for the best database management tool written in PHP, Adminer

You should take a look to the official github profile (https://github.com/dg/adminer-custom).

![Adminer DG](https://rawgit.com/dockette/adminer/master/.docs/assets/adminer-dg.png)

## Maintenance

**Upgrade Adminer and Adminer Editor versions to X.Y.Z**

```bash
ADMINER_VERSION=4.8.1 make update-versions
```
