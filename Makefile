DOCKER_IMAGE=dockette/adminer
DOCKER_PLATFORMS?=linux/amd64
DOCKER_RUN_PORT?=8000
DOCKER_RUN_TAG?=full

.DEFAULT_GOAL := help

##@ Help

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_.-]+:.*##/ { sub(/^ +/, "", $$2); printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) }' $(firstword $(MAKEFILE_LIST))

##@ Docker

.PHONY: build
build: build-all ## Build all variant images

.PHONY: test
test: test-all ## Test all variant images

.PHONY: run
run: ## Run one image on port 8000 (DOCKER_RUN_TAG=full)
	docker run --rm -it -p ${DOCKER_RUN_PORT}:80 ${DOCKER_IMAGE}:${DOCKER_RUN_TAG}

.PHONY: build-all
build-all: build-full build-dg build-editor build-mongo build-mssql build-mysql build-postgres build-oracle-11 build-oracle-12 build-oracle-19 ## Build all variant images

.PHONY: test-all
test-all: test-full test-dg test-editor test-mongo test-mssql test-mysql test-postgres test-oracle-11 test-oracle-12 test-oracle-19 ## Run php --version in all variant images

_docker-build-%: TAG=$*
_docker-build-%:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:${TAG} -f ./adminer-${TAG}/Dockerfile .

_docker-test-%: TAG=$*
_docker-test-%:
	docker run --rm --platform ${DOCKER_PLATFORMS} ${DOCKER_IMAGE}:${TAG} php --version

_docker-run-%: TAG=$*
_docker-run-%:
	docker run --rm -it -p ${DOCKER_RUN_PORT}:80 ${DOCKER_IMAGE}:${TAG}

##@ Build Variants

.PHONY: build-full
build-full: _docker-build-full ## Build the full (MySQL, PostgreSQL, SQLite, MongoDB) image

.PHONY: build-dg
build-dg: _docker-build-dg ## Build the adminer-custom image

.PHONY: build-editor
build-editor: _docker-build-editor ## Build the Adminer Editor image

.PHONY: build-mongo
build-mongo: _docker-build-mongo ## Build the MongoDB image

.PHONY: build-mssql
build-mssql: _docker-build-mssql ## Build the MS SQL Server image

.PHONY: build-mysql
build-mysql: _docker-build-mysql ## Build the MySQL image

.PHONY: build-postgres
build-postgres: _docker-build-postgres ## Build the PostgreSQL image

.PHONY: build-oracle-11
build-oracle-11: _docker-build-oracle-11 ## Build the Oracle 11 image

.PHONY: build-oracle-12
build-oracle-12: _docker-build-oracle-12 ## Build the Oracle 12 image

.PHONY: build-oracle-19
build-oracle-19: _docker-build-oracle-19 ## Build the Oracle 19 image

##@ Test Variants

.PHONY: test-full
test-full: _docker-test-full ## Test the full (MySQL, PostgreSQL, SQLite, MongoDB) image

.PHONY: test-dg
test-dg: _docker-test-dg ## Test the adminer-custom image

.PHONY: test-editor
test-editor: _docker-test-editor ## Test the Adminer Editor image

.PHONY: test-mongo
test-mongo: _docker-test-mongo ## Test the MongoDB image

.PHONY: test-mssql
test-mssql: _docker-test-mssql ## Test the MS SQL Server image

.PHONY: test-mysql
test-mysql: _docker-test-mysql ## Test the MySQL image

.PHONY: test-postgres
test-postgres: _docker-test-postgres ## Test the PostgreSQL image

.PHONY: test-oracle-11
test-oracle-11: _docker-test-oracle-11 ## Test the Oracle 11 image

.PHONY: test-oracle-12
test-oracle-12: _docker-test-oracle-12 ## Test the Oracle 12 image

.PHONY: test-oracle-19
test-oracle-19: _docker-test-oracle-19 ## Test the Oracle 19 image

##@ Run Variants

.PHONY: run-full
run-full: _docker-run-full ## Run the full (MySQL, PostgreSQL, SQLite, MongoDB) image on port 8000

.PHONY: run-dg
run-dg: _docker-run-dg ## Run the adminer-custom image on port 8000

.PHONY: run-editor
run-editor: _docker-run-editor ## Run the Adminer Editor image on port 8000

.PHONY: run-mongo
run-mongo: _docker-run-mongo ## Run the MongoDB image on port 8000

.PHONY: run-mssql
run-mssql: _docker-run-mssql ## Run the MS SQL Server image on port 8000

.PHONY: run-mysql
run-mysql: _docker-run-mysql ## Run the MySQL image on port 8000

.PHONY: run-postgres
run-postgres: _docker-run-postgres ## Run the PostgreSQL image on port 8000

.PHONY: run-oracle-11
run-oracle-11: _docker-run-oracle-11 ## Run the Oracle 11 image on port 8000

.PHONY: run-oracle-12
run-oracle-12: _docker-run-oracle-12 ## Run the Oracle 12 image on port 8000

.PHONY: run-oracle-19
run-oracle-19: _docker-run-oracle-19 ## Run the Oracle 19 image on port 8000

##@ Maintenance

.PHONY: update-versions
update-versions: ## Set ENV ADMINER_VERSION in every Dockerfile (ADMINER_VERSION=x, BSD sed)
	find . -type f -name Dockerfile -exec sed -i '' 's/ENV ADMINER_VERSION=.*/ENV ADMINER_VERSION=${ADMINER_VERSION}/g' {} +
	find . -type f -name Dockerfile -exec sed -i '' 's/ENV ADMINER_EDITOR_VERSION=.*/ENV ADMINER_EDITOR_VERSION=${ADMINER_VERSION}/g' {} +
