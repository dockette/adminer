# Adminer / Adminer Editor / Adminer Custom

> Database management in a single PHP file.

You should take a look to the official github profile (https://github.com/vrana/adminer).

![Adminer](https://rawgit.com/dockette/adminer/master/.docs/assets/adminer.png)

<p align=center>
  <a href="https://hub.docker.com/r/dockette/adminer/"><img src="https://badgen.net/docker/pulls/dockette/adminer"></a>
  <a href="https://bit.ly/ctteg"><img src="https://badgen.net/badge/support/gitter/cyan"></a>
  <a href="https://github.com/sponsors/f3l1x"><img src="https://badgen.net/badge/sponsor/donations/F96854"></a>
</p>

------

## Prologue

There are few variants of this adminer image based:

- full (mysql, pgsql, sqlite, mongo)
- mysql (only)
- pgsql (only)
- mongo (only)
- dg (custom)

**Features**

- Alpine Linux (full, editor, df, mongo, mysql, postgres)
- Debian Buster (oracle-11, oracle-12)
- PHP 8 (concurrency via PHP cli workers)

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
