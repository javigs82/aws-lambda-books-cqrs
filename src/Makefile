## Project
REPO_URL=$(shell git config --get remote.origin.url)
PROJECT_NAME = $(shell basename -s .git "${REPO_URL}")
VERSION = $(shell cat ./../version.txt)

#ENV VARS
AWS_DEFAULT_REGION ?= eu-west-1


## Docker
ARTIFACTORY_LOCATION ?= artifactory.app.io
ARTIFACTORY_REPOSITORY ?= lambdas
DOCKER_IMAGE_URI=${ARTIFACTORY_LOCATION}/${ARTIFACTORY_REPOSITORY}/${PROJECT_NAME}:${VERSION}

ACCOUNT_NUMBER=$(shell aws sts get-caller-identity --query 'Account')
ECR_LOCATION=$(ACCOUNT_NUMBER).dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com
DOCKER_IMAGE_URI_AWS=${ECR_LOCATION}/${PROJECT_NAME}:${VERSION}

## Docker
docker-build:
	@echo "Building Docker Image: ${DOCKER_IMAGE_URI} "
	docker buildx build --platform linux/amd64 --network host --rm -t ${DOCKER_IMAGE_URI} .

docker-publish-ecr:
	docker tag ${DOCKER_IMAGE_URI} ${DOCKER_IMAGE_URI_AWS}
	aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin $(ECR_LOCATION)
	aws ecr create-repository --repository-name ${PROJECT_NAME} 2>/dev/null || true
	docker push ${DOCKER_IMAGE_URI_AWS}

## Python
python-run:
	python3 app.py

## Test
run-unit-tests:
	@echo "Running python unit tests"

run-integration-tests:
	@echo "Running integration tests"