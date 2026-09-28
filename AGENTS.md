# Dockette / Adminer

Instructions for AI coding agents working in this repository.

## Overview

`dockette/adminer` serves the Adminer database UI with the PHP built-in web server on port `80`, one image per
database driver set. It is a service image (see IMAGES.md): upstream `adminer-{version}.php` plus our entrypoint,
three plugins in `.plugins/` and the upstream themes. It is not a database and holds no data.

- **Image**: `dockette/adminer`, tags `full`, `editor`, `mysql`, `postgres`, `mongo`, `mssql`, `oracle-11`,
  `oracle-12`, `oracle-19`, `dg`; `latest` is built from `adminer-full/`
- **Base**: official `alpine:3.23` (`alpine:3.22` for `mysql`) with PHP 8.4 from the community repository;
  `dockette/debian:bookworm-slim` with PHP 8.4 from `packages.sury.org` for `mssql` and `oracle-*`
- **Adminer**: `ENV ADMINER_VERSION=6.1.0` (`ADMINER_EDITOR_VERSION` in `editor`), downloaded from GitHub releases
- **Platforms**: `linux/amd64`, `linux/arm64`; `mssql` and `oracle-*` are `linux/amd64` only
- **Layout**: one folder per variant (`adminer-full/`), each with a `Dockerfile` and an `entrypoint.sh`; shared
  plugins in `.plugins/`; screenshots in `.docs/assets/`

## Documentation

- `DESIGN.md` describes what we change in the UI (themes, plugins, login form). Read it before changing
  `.plugins/`, a theme or the theme and plugin code in `entrypoint.sh`.
- `README.md` holds the tag list, the environment variables and the theme screenshots, and is the Docker Hub
  description; the `docs` job publishes it from `master`.
- `docker-compose.yml` builds `adminer-full` next to MariaDB and PostgreSQL with the server list plugin on.
- Organization rules are in [dockette/dockette specs](https://github.com/dockette/dockette/tree/master/specs).

## Commands

```bash
# Build and test all ten variants (build = build-all, test = test-all)
make build
make test

# Build, test and run one variant on port 8000
make build-mysql
make test-mysql
make run-mysql
make run DOCKER_RUN_TAG=postgres

# Try the plugins against real databases
docker compose up --build
```

`make test` only runs `php --version`. CI does more: the `test` job builds each tag for `linux/amd64` with
`docker/build-push-action`, runs `php --version`, starts the container and checks that `curl` on port `80`
returns a page containing "adminer". The `build` job pushes every tag from `master` only. There is no `VERSION`
variable; use the per-variant targets.

## Conventions

- Build from the repository root: `-f ./adminer-{tag}/Dockerfile .`, so `.plugins/` can be copied. The Makefile
  and the workflow both do this.
- A new variant is a folder `adminer-{tag}/`, `build-`, `test-` and `run-` targets plus the `build-all` and
  `test-all` lists in the `Makefile`, an entry in both workflow matrices and a README row.
- Plugins are opt-in: `ADMINER_PLUGIN_{NAME}=1` copies `.plugins/adminer-{name}.php` into `/srv/adminer-plugins/`,
  which Adminer loads on its own.

## Traps

- **Every `entrypoint.sh` is a separate copy.** They differ on purpose: only `full` copies the upstream driver
  plugins, `mssql` enables `mssql-encrypt` by default and has no autologin or server list, `dg` has no plugins
  and no themes. Apply a shared change to each folder that has the feature.
- **The `dg` variant is not upstream Adminer.** It downloads the `adminer-custom` release archive
  (`ENV ADMINER_DG_VERION`, spelled that way) and `update-versions` does not touch it.
- **`make update-versions` needs BSD `sed`.** It runs `sed -i ''`, which fails with GNU `sed` on Linux. It sets
  `ADMINER_VERSION` and `ADMINER_EDITOR_VERSION` in every `Dockerfile`.
- **`WORKERS` has no effect at runtime.** `PHP_CLI_SERVER_WORKERS=${WORKERS}` is resolved at build time, so
  `-e WORKERS=4` changes nothing; `-e PHP_CLI_SERVER_WORKERS=4` does.
- **Autologin wins over the server list.** The entrypoints use `if`/`elif`, so both variables set means only
  `adminer-autologin.php` is active.
- **Autologin opens the database to anyone who reaches the port.** The DSN credentials are used for every
  visitor without a login form; never publish such a container.
- **Oracle Instant Client comes from outside Oracle for 11 and 12.** `oracle-11` and `oracle-12` download the zips
  from `github.com/f00b4r/oracle-instantclient`; `oracle-19` downloads from `download.oracle.com`. None is
  checksum-verified.
- **There is no `.dockerignore`.** The build context is the whole repository, including `.docs/`. It is safe only
  because each `Dockerfile` copies named paths; keep it that way.
- Usage for image users (environment variables, plugins, themes, ports) lives in `README.md`, not here.
