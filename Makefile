.PHONY:

ADMINER_VERSION=5.1.0
DOCKER_IMAGE=dockette/adminer
DOCKER_PLATFORMS=linux/amd64

build-all: build-full build-dg build-editor build-mongo build-mysql build-postgres build-oracle-11 build-oracle-12

build-full:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:full ./adminer-full

build-dg:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:dg ./adminer-dg

build-editor:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:editor ./adminer-editor

build-mongo:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:mongo ./adminer-mongo

build-mysql:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:mysql ./adminer-mysql

build-oracle-11:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:oracle-11 ./adminer-oracle-11

build-oracle-12:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:oracle-12 ./adminer-oracle-12

build-postgres:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:postgres ./adminer-postgres

update-versions:
	find . -type f -name Dockerfile -exec sed -i '' 's/ENV ADMINER_VERSION=.*/ENV ADMINER_VERSION=${ADMINER_VERSION}/g' {} +
	find . -type f -name Dockerfile -exec sed -i '' 's/ENV ADMINER_EDITOR_VERSION=.*/ENV ADMINER_EDITOR_VERSION=${ADMINER_VERSION}/g' {} +
