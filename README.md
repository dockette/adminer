<h1 align=center>Dockette / Adminer</h1>

<p align=center>
   <a href="https://github.com/dockette/adminer/actions"><img src="https://github.com/dockette/adminer/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/adminer"><img src="https://img.shields.io/docker/pulls/dockette/adminer.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

<p align=center>
   <a href="https://www.adminer.org">Adminer</a> 6.1.0, the single-file database manager, served by the PHP 8.4 built-in web server. Each tag carries the drivers for one database (<code>mysql</code>, <code>postgres</code>, <code>mongo</code>, <code>mssql</code>, <code>oracle-19</code>) or for several (<code>full</code>), on Alpine Linux or Debian Bookworm. For developers who need a database UI next to a local or staging stack.
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

<p align=center>
   <img src=".docs/assets/adminer.png" alt="Adminer login screen" width="100%">
</p>

-----

## Usage

Run Adminer with the MySQL, PostgreSQL, SQLite and MongoDB drivers on port `8000`:

```sh
docker run --rm -p 8000:80 dockette/adminer:full
```

Open `http://localhost:8000` and log in to your database server. The image is based on `alpine:3.23` and needs
no volume. It listens on port `80`, runs as root and has no `HEALTHCHECK`.

Change the PHP limits and the port:

```sh
docker run --rm -p 8000:8080 \
    -e MEMORY=512M \
    -e UPLOAD=4096M \
    -e PORT=8080 \
    dockette/adminer:full
```

> [!CAUTION]
> Adminer gives full access to every database it can reach. Don't expose the port to the internet, and never
> publish a container with the autologin plugin enabled.

## Versions

| Tag | Description |
|-----|-------------|
| `dockette/adminer:full` | MySQL, PostgreSQL, SQLite and MongoDB drivers, plus the upstream driver plugins; Alpine 3.23 |
| `dockette/adminer:latest` | Same as `full` |
| `dockette/adminer:editor` | [Adminer Editor](https://www.adminer.org/en/editor/) (data only) with MySQL, PostgreSQL and MongoDB; Alpine 3.23 |
| `dockette/adminer:mysql` | MySQL and MariaDB; Alpine 3.22 |
| `dockette/adminer:postgres` | PostgreSQL; Alpine 3.23 |
| `dockette/adminer:mongo` | MongoDB; Alpine 3.23 |
| `dockette/adminer:mssql` | MS SQL Server with Microsoft ODBC Driver 18 and `sqlsrv`, `pdo_sqlsrv`; Debian Bookworm, `linux/amd64` only |
| `dockette/adminer:oracle-19` | Oracle with Instant Client 19.30 and `oci8`; Debian Bookworm, `linux/amd64` only |
| `dockette/adminer:oracle-12` | Oracle with Instant Client 12.1 and `oci8`; Debian Bookworm, `linux/amd64` only |
| `dockette/adminer:oracle-11` | Oracle with Instant Client 11.2 and `oci8`; Debian Bookworm, `linux/amd64` only |
| `dockette/adminer:dg` | The `adminer-custom` 3.4.1 build with MySQL, PostgreSQL and MongoDB; Alpine 3.23. No plugins or themes |

The Alpine tags are built for `linux/amd64` and `linux/arm64`; Microsoft and Oracle ship their drivers for
`amd64` only. Every tag is rebuilt every Monday.

## Environment

| Variable | Default | Description |
|----------|---------|-------------|
| `MEMORY` | `256M` | PHP `memory_limit` |
| `UPLOAD` | `2048M` | PHP `upload_max_filesize` and `post_max_size` |
| `PORT` | `80` | Port of the PHP built-in web server inside the container |
| `PHP_CLI_SERVER_WORKERS` | `8` | Number of PHP server workers. `WORKERS` only sets it at build time |
| `ADMINER_THEME` | (none) | Theme name from the table below |
| `ADMINER_PLUGIN_AUTOLOGIN` | (off) | `1` enables the autologin plugin |
| `ADMINER_AUTOLOGIN_SERVER` | (none) | DSN for autologin |
| `ADMINER_PLUGIN_SERVER_LIST` | (off) | `1` enables the server list plugin |
| `ADMINER_SERVERS_{Name}` | (none) | DSN of one server in the list; `{Name}` is its label |
| `ADMINER_PLUGIN_MSSQL_ENCRYPT` | (on) | `mssql` only: `0` disables the encryption plugin |
| `ADMINER_MSSQL_ENCRYPT` | (not set) | `mssql` only: `yes`, `no` or `strict` |
| `ADMINER_MSSQL_TRUST_CERT` | `yes` | `mssql` only: `TrustServerCertificate`, `yes` or `no` |
| `ADMINER_BANNER` | (on) | `0`, `false`, `no` or `off` hides the start banner |
| `ADMINER_DEBUG` | (off) | `1` traces the entrypoint with `set -x` |

The `ADMINER_*` variables for themes and plugins work in every tag except `dg`.

## Plugins

Plugins are off by default. A DSN has the form `driver://username:password@host:port/database`, where `driver`
is the Adminer driver name: `server` (MySQL and MariaDB), `pgsql`, `sqlite`, `oracle` or `mongo`.

### Autologin

Autologin skips the login form and connects to one server with the credentials from the DSN:

```sh
docker run --rm -p 8000:80 \
    -e ADMINER_PLUGIN_AUTOLOGIN=1 \
    -e ADMINER_AUTOLOGIN_SERVER=server://root:secret@mysql:3306/mydb \
    dockette/adminer:full
```

### Server List

The server list replaces the server field with a dropdown of preset servers and adds an Auto Sign-In button for
servers with stored credentials. The credentials stay on the server and never reach the browser:

```sh
docker run --rm -p 8000:80 \
    -e ADMINER_PLUGIN_SERVER_LIST=1 \
    -e ADMINER_SERVERS_MySQL=server://root:secret@mysql:3306/mydb \
    -e ADMINER_SERVERS_PostgreSQL=pgsql://postgres:pwd@pg:5432/app \
    -e ADMINER_SERVERS_DevDB=server://devhost:3306 \
    dockette/adminer:full
```

A server without credentials in its DSN, like `DevDB` above, is listed but needs a manual login.

> [!NOTE]
> Autologin takes precedence. When both plugins are enabled, only autologin is active.

### MSSQL Encryption

The `mssql` tag enables its encryption plugin by default with `TrustServerCertificate=yes`, so it connects to
servers with self-signed certificates:

```sh
docker run --rm -p 8000:80 -e ADMINER_MSSQL_ENCRYPT=strict -e ADMINER_MSSQL_TRUST_CERT=no dockette/adminer:mssql
```

The `mssql` tag has no autologin and no server list.

## Themes

`ADMINER_THEME` selects one of the themes from the Adminer release:

```sh
docker run --rm -p 8000:80 -e ADMINER_THEME=dracula dockette/adminer:full
```

When the theme is not found, the container prints the available names and starts with the default look.

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

## Adminer Custom

The `dg` tag serves the [`adminer-custom`](https://github.com/dg/adminer-custom) project, a customised Adminer with its own plugins and look, instead of
the upstream release:

```sh
docker run --rm -p 8000:80 dockette/adminer:dg
```

<img src=".docs/assets/adminer-dg.png" alt="adminer-custom login screen" width="100%">

## Compose

The [`docker-compose.yml`](https://github.com/dockette/adminer/blob/master/docker-compose.yml) in this repository
builds the `full` image and starts it on port `8080` next to MariaDB 11 and PostgreSQL 17, with the server list
plugin enabled:

```sh
docker compose up --build
```

## Development

Build and test all tags, or build and run one of them on port `8000`:

```sh
make build
make test
make build-mysql
make run-mysql
```

`make test` runs `php --version` in each image. `make help` lists every target. To move all Dockerfiles to a new
Adminer release (the `sed` call needs macOS or BSD `sed`):

```sh
ADMINER_VERSION=6.1.0 make update-versions
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider [supporting](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
