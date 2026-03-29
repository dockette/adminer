<h1 align=center>Dockette / Adminer</h1>

<p align=center>
   🎁 Tiniest boxed dockerized Adminer (MySQL, PostgreSQL, SQLite, Mongo, Oracle) Dockerfiles. Database management in a single PHP file.
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

<p align=center>
  <a href="https://hub.docker.com/r/dockette/adminer/"><img src="https://badgen.net/docker/pulls/dockette/adminer"></a>
  <a href="https://bit.ly/ctteg"><img src="https://badgen.net/badge/support/gitter/cyan"></a>
  <a href="https://github.com/sponsors/f3l1x"><img src="https://badgen.net/badge/sponsor/donations/F96854"></a>
</p>

![Adminer](https://rawgit.com/dockette/adminer/master/.docs/assets/adminer.png)

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

| Theme | Preview |
|-------|---------|
| default (no theme) | ![default](.docs/assets/themes/default.png) |
| `adminer-dark` | ![adminer-dark](.docs/assets/themes/adminer-dark.png) |
| `brade` | ![brade](.docs/assets/themes/brade.png) |
| `bueltge` | ![bueltge](.docs/assets/themes/bueltge.png) |
| `dracula` | ![dracula](.docs/assets/themes/dracula.png) |
| `esterka` | ![esterka](.docs/assets/themes/esterka.png) |
| `flat` | ![flat](.docs/assets/themes/flat.png) |
| `galkaev` | ![galkaev](.docs/assets/themes/galkaev.png) |
| `haeckel` | ![haeckel](.docs/assets/themes/haeckel.png) |
| `hever` | ![hever](.docs/assets/themes/hever.png) |
| `konya` | ![konya](.docs/assets/themes/konya.png) |
| `lavender-light` | ![lavender-light](.docs/assets/themes/lavender-light.png) |
| `lucas-sandery` | ![lucas-sandery](.docs/assets/themes/lucas-sandery.png) |
| `mancave` | ![mancave](.docs/assets/themes/mancave.png) |
| `mvt` | ![mvt](.docs/assets/themes/mvt.png) |
| `nette` | ![nette](.docs/assets/themes/nette.png) |
| `ng9` | ![ng9](.docs/assets/themes/ng9.png) |
| `nicu` | ![nicu](.docs/assets/themes/nicu.png) |
| `pappu687` | ![pappu687](.docs/assets/themes/pappu687.png) |
| `paranoiq` | ![paranoiq](.docs/assets/themes/paranoiq.png) |
| `pepa-linha` | ![pepa-linha](.docs/assets/themes/pepa-linha.png) |
| `pokorny` | ![pokorny](.docs/assets/themes/pokorny.png) |
| `price` | ![price](.docs/assets/themes/price.png) |
| `rmsoft` | ![rmsoft](.docs/assets/themes/rmsoft.png) |
| `rmsoft_blue` | ![rmsoft_blue](.docs/assets/themes/rmsoft_blue.png) |
| `rmsoft_blue-dark` | ![rmsoft_blue-dark](.docs/assets/themes/rmsoft_blue-dark.png) |
| `win98` | ![win98](.docs/assets/themes/win98.png) |

## Maintenance

**Upgrade Adminer and Adminer Editor versions to X.Y.Z**

```bash
ADMINER_VERSION=4.8.1 make update-versions
```
