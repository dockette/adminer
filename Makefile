DOCKER_IMAGE=dockette/adminer
DOCKER_PLATFORMS?=linux/amd64

build-all: build-full build-dg build-editor build-mongo build-mysql build-postgres build-oracle-11 build-oracle-12 build-oracle-19

_docker-build-%: TAG=$*
_docker-build-%:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:${TAG} ./adminer-${TAG}

build-full: _docker-build-full
build-dg: _docker-build-dg
build-editor: _docker-build-editor
build-mongo: _docker-build-mongo
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
test-mysql: _docker-test-mysql
test-postgres: _docker-test-postgres
test-oracle-11: _docker-test-oracle-11
test-oracle-12: _docker-test-oracle-12
test-oracle-19: _docker-test-oracle-19

test-all: test-full test-dg test-editor test-mongo test-mysql test-postgres test-oracle-11 test-oracle-12 test-oracle-19

update-versions:
	find . -type f -name Dockerfile -exec sed -i '' 's/ENV ADMINER_VERSION=.*/ENV ADMINER_VERSION=${ADMINER_VERSION}/g' {} +
	find . -type f -name Dockerfile -exec sed -i '' 's/ENV ADMINER_EDITOR_VERSION=.*/ENV ADMINER_EDITOR_VERSION=${ADMINER_VERSION}/g' {} +
