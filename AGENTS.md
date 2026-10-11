# Dockette / Adminer

Adminer database UI served by the PHP built-in web server, one image per database driver set.

## Stack

- Docker image built with `docker buildx`, base `alpine:3.23` or `dockette/debian:bookworm-slim` (MS SQL, Oracle)
- Adminer 6.1.0 on PHP 8
- Published to Docker Hub as `dockette/adminer` for linux/amd64 and linux/arm64 by GitHub Actions

## Development

```bash
make build       # build all variant images
make test        # smoke test all variant images
make run         # run one image on port 8000 (DOCKER_RUN_TAG=full)
make build-full  # build one variant; also test-full, run-full
```

Run `make` to list every target.

## Principles

- KISS: one image does one job; no extra services or tools.
- DRY: shared steps live in the base image, not copied into every Dockerfile.
- YAGNI: add a package only when the image needs it.
- Pin versions, keep layers small, clean package caches in the same `RUN`.
- Every change is built and smoke tested with `make build test` before a commit.
