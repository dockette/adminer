DOCKER_IMAGE=dockette/adminer
DOCKER_PLATFORMS?=linux/amd64
DOCKER_RUN_PORT?=8000
DOCKER_RUN_TAG?=full

build: build-all

test: test-all

run:
	docker run --rm -it -p ${DOCKER_RUN_PORT}:80 ${DOCKER_IMAGE}:${DOCKER_RUN_TAG}

build-all: build-full build-dg build-editor build-mongo build-mssql build-mysql build-postgres build-oracle-11 build-oracle-12 build-oracle-19

_docker-build-%: TAG=$*
_docker-build-%:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:${TAG} -f ./adminer-${TAG}/Dockerfile .

build-full: _docker-build-full
build-dg: _docker-build-dg
build-editor: _docker-build-editor
build-mongo: _docker-build-mongo
build-mssql: _docker-build-mssql
build-mysql: _docker-build-mysql
build-postgres: _docker-build-postgres
build-oracle-11: _docker-build-oracle-11
build-oracle-12: _docker-build-oracle-12
build-oracle-19: _docker-build-oracle-19

_docker-test-%: TAG=$*
_docker-test-%:
	docker run --rm --platform ${DOCKER_PLATFORMS} ${DOCKER_IMAGE}:${TAG} php --version

test-full: _docker-test-full
test-dg: _docker-test-dg
test-editor: _docker-test-editor
test-mongo: _docker-test-mongo
test-mssql: _docker-test-mssql
test-mysql: _docker-test-mysql
test-postgres: _docker-test-postgres
test-oracle-11: _docker-test-oracle-11
test-oracle-12: _docker-test-oracle-12
test-oracle-19: _docker-test-oracle-19

test-all: test-full test-dg test-editor test-mongo test-mssql test-mysql test-postgres test-oracle-11 test-oracle-12 test-oracle-19

_docker-run-%: TAG=$*
_docker-run-%:
	docker run --rm -it -p ${DOCKER_RUN_PORT}:80 ${DOCKER_IMAGE}:${TAG}

run-full: _docker-run-full
run-dg: _docker-run-dg
run-editor: _docker-run-editor
run-mongo: _docker-run-mongo
run-mssql: _docker-run-mssql
run-mysql: _docker-run-mysql
run-postgres: _docker-run-postgres
run-oracle-11: _docker-run-oracle-11
run-oracle-12: _docker-run-oracle-12
run-oracle-19: _docker-run-oracle-19

update-versions:
	find . -type f -name Dockerfile -exec sed -i '' 's/ENV ADMINER_VERSION=.*/ENV ADMINER_VERSION=${ADMINER_VERSION}/g' {} +
	find . -type f -name Dockerfile -exec sed -i '' 's/ENV ADMINER_EDITOR_VERSION=.*/ENV ADMINER_EDITOR_VERSION=${ADMINER_VERSION}/g' {} +
