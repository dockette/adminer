.PHONY:

ADMINER_VERSION=4.8.1
DOCKER_IMAGE=dockette/adminer

build-full:
	docker build -t ${DOCKER_IMAGE}:full ./adminer-full

build-dg:
	docker build -t ${DOCKER_IMAGE}:dg ./adminer-dg

build-editor:
	docker build -t ${DOCKER_IMAGE}:editor ./adminer-editor

build-mongo:
	docker build -t ${DOCKER_IMAGE}:mongo ./adminer-mongo

build-mysql:
	docker build -t ${DOCKER_IMAGE}:mysql ./adminer-mysql

build-oracle-11:
	docker build -t ${DOCKER_IMAGE}:oracle-11 ./adminer-oracle-11

build-oracle-12:
	docker build -t ${DOCKER_IMAGE}:oracle-12 ./adminer-oracle-12

build-postgres:
	docker build -t ${DOCKER_IMAGE}:postgres ./adminer-postgres

update-versions:
	find . -type f -name Dockerfile -exec sed -i '' 's/ENV ADMINER_VERSION=.*/ENV ADMINER_VERSION=${ADMINER_VERSION}/g' {} +
	find . -type f -name Dockerfile -exec sed -i '' 's/ENV ADMINER_EDITOR_VERSION=.*/ENV ADMINER_EDITOR_VERSION=${ADMINER_VERSION}/g' {} +
