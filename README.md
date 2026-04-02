<h1 align=center>Dockette / Adminer</h1>

<p align=center>
   🎁 Tiniest boxed dockerized Adminer (MySQL, PostgreSQL, SQLite, Mongo, Oracle, MSSQL) Dockerfiles. Database management in a single PHP file.
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

<p align=center>
  <a href="https://hub.docker.com/r/dockette/adminer/"><img src="https://badgen.net/docker/pulls/dockette/adminer"></a>
  <a href="https://bit.ly/ctteg"><img src="https://badgen.net/badge/support/gitter/cyan"></a>
  <a href="https://github.com/sponsors/f3l1x"><img src="https://badgen.net/badge/sponsor/donations/F96854"></a>
</p>

![Adminer](.docs/assets/adminer.png)

------

## Prologue

There are few variants of this adminer image based:

- full (mysql, pgsql, sqlite, mongo)
- mysql (only)
- pgsql (only)
- mongo (only)
- mssql (only)
- oracle-11 / oracle-12 / oracle-19 (only)
- dg (custom)

**Features**

- Alpine Linux (full, editor, dg, mongo, mysql, postgres)
- Debian Bookworm (mssql, oracle-11, oracle-12, oracle-19)
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
- `PORT=80` (PHP server listening port)
- `WORKERS=4` (concurrency)

```sh
docker run \
    --rm
    -p 8000:8080
    -e MEMORY=512M
    -e UPLOAD=4096M
    -e PORT=8080
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
| dockette/adminer:mssql       | MS SQL Server                         | -    | [link](https://hub.docker.com/r/dockette/adminer/tags/) |
| dockette/adminer:dg          | MySQL / PostgreSQL / MongoDB / Sqlite | 16mb | [link](https://hub.docker.com/r/dockette/adminer/tags/) |

### `dockette/adminer:mssql`

Debian-based image with Microsoft ODBC Driver 18 and PHP `sqlsrv` / `pdo_sqlsrv` extensions.

```sh
docker run \
    --rm \
    -p 8080:80 \
    dockette/adminer:mssql
```

By default, `TrustServerCertificate` is set to `yes` so the image works out of the box with self-signed certificates (common in development). You can control encryption behavior via environment variables:

| Variable | Description | Default |
|---|---|---|
| `ADMINER_PLUGIN_MSSQL_ENCRYPT` | Set to `0` to disable the encryption plugin | enabled |
| `ADMINER_MSSQL_ENCRYPT` | `yes`, `no`, or `strict` | not set |
| `ADMINER_MSSQL_TRUST_CERT` | `yes` or `no` | `yes` |

### `dockette/adminer:dg`

> Customization for the best database management tool written in PHP, Adminer

You should take a look to the official github profile (https://github.com/dg/adminer-custom).

![Adminer DG](.docs/assets/adminer-dg.png)

## Themes

You can apply a theme by setting the `ADMINER_THEME` environment variable:

```sh
docker run \
    --rm
    -p 8000:80
    -e ADMINER_THEME=dracula
    dockette/adminer:full
```

If the specified theme is not found, the container will list all available themes.

### Available Themes

<table>
<tr>
<td align="center"><strong>default</strong><br><img src=".docs/assets/themes/default.png" width="200"></td>
<td align="center"><strong>adminer-dark</strong><br><img src=".docs/assets/themes/adminer-dark.png" width="200"></td>
<td align="center"><strong>brade</strong><br><img src=".docs/assets/themes/brade.png" width="200"></td>
<td align="center"><strong>bueltge</strong><br><img src=".docs/assets/themes/bueltge.png" width="200"></td>
<td align="center"><strong>dracula</strong><br><img src=".docs/assets/themes/dracula.png" width="200"></td>
</tr>
<tr>
<td align="center"><strong>esterka</strong><br><img src=".docs/assets/themes/esterka.png" width="200"></td>
<td align="center"><strong>flat</strong><br><img src=".docs/assets/themes/flat.png" width="200"></td>
<td align="center"><strong>galkaev</strong><br><img src=".docs/assets/themes/galkaev.png" width="200"></td>
<td align="center"><strong>haeckel</strong><br><img src=".docs/assets/themes/haeckel.png" width="200"></td>
<td align="center"><strong>hever</strong><br><img src=".docs/assets/themes/hever.png" width="200"></td>
</tr>
<tr>
<td align="center"><strong>konya</strong><br><img src=".docs/assets/themes/konya.png" width="200"></td>
<td align="center"><strong>lavender-light</strong><br><img src=".docs/assets/themes/lavender-light.png" width="200"></td>
<td align="center"><strong>lucas-sandery</strong><br><img src=".docs/assets/themes/lucas-sandery.png" width="200"></td>
<td align="center"><strong>mancave</strong><br><img src=".docs/assets/themes/mancave.png" width="200"></td>
<td align="center"><strong>mvt</strong><br><img src=".docs/assets/themes/mvt.png" width="200"></td>
</tr>
<tr>
<td align="center"><strong>nette</strong><br><img src=".docs/assets/themes/nette.png" width="200"></td>
<td align="center"><strong>ng9</strong><br><img src=".docs/assets/themes/ng9.png" width="200"></td>
<td align="center"><strong>nicu</strong><br><img src=".docs/assets/themes/nicu.png" width="200"></td>
<td align="center"><strong>pappu687</strong><br><img src=".docs/assets/themes/pappu687.png" width="200"></td>
<td align="center"><strong>paranoiq</strong><br><img src=".docs/assets/themes/paranoiq.png" width="200"></td>
</tr>
<tr>
<td align="center"><strong>pepa-linha</strong><br><img src=".docs/assets/themes/pepa-linha.png" width="200"></td>
<td align="center"><strong>pokorny</strong><br><img src=".docs/assets/themes/pokorny.png" width="200"></td>
<td align="center"><strong>price</strong><br><img src=".docs/assets/themes/price.png" width="200"></td>
<td align="center"><strong>rmsoft</strong><br><img src=".docs/assets/themes/rmsoft.png" width="200"></td>
<td align="center"><strong>rmsoft_blue</strong><br><img src=".docs/assets/themes/rmsoft_blue.png" width="200"></td>
</tr>
<tr>
<td align="center"><strong>rmsoft_blue-dark</strong><br><img src=".docs/assets/themes/rmsoft_blue-dark.png" width="200"></td>
<td align="center"><strong>win98</strong><br><img src=".docs/assets/themes/win98.png" width="200"></td>
<td></td>
<td></td>
<td></td>
</tr>
</table>

## Upgrade

**Upgrade Adminer and Adminer Editor versions to X.Y.Z**

```bash
ADMINER_VERSION=4.8.1 make update-versions
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package.
