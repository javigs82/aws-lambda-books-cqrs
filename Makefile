SHELL := /bin/bash

# PROJECT
REPO_URL=$(shell git config --get remote.origin.url)
PROJECT_NAME = $(shell basename -s .git "${REPO_URL}")
VERSION ?= $(shell cat ./version.txt)

# ENV VARS
ENV ?= sandbox
AWS_DEFAULT_REGION ?= eu-west-1
ROLE_ARN ?=

## Terraform VARS
export TF_VAR_cmp_name = $(PROJECT_NAME)
export TF_VAR_cmp_version = $(VERSION)
export TF_VAR_env = ${ENV}
export TF_VAR_aws_region = ${AWS_DEFAULT_REGION}
export TF_VAR_role_arn = ${ROLE_ARN}

## Docker for lambdas
ACCOUNT_NUMBER=$(shell aws sts get-caller-identity --query 'Account')
ECR_LOCATION=$(ACCOUNT_NUMBER).dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com
DOCKER_IMAGE_URI_AWS=${ECR_LOCATION}/${PROJECT_NAME}

# TARGETS
## Terraform
terraform-init:
	terraform init

terraform-validate:
	terraform fmt -check -recursive -diff
	terraform validate

terraform-format:
	terraform fmt -recursive

terraform-plan:
	terraform plan

terraform-plan-destroy:
	terraform plan -destroy

terraform-apply:
	terraform apply -auto-approve

terraform-destroy:
	terraform destroy -auto-approve

terraform-console:
	terraform console

# Docker
## Docker
docker-build:

	@echo "Building Docker Image: ${DOCKER_IMAGE_URI_AWS}-query:${VERSION} "
	docker buildx build --platform linux/amd64 --network host --rm -t ${DOCKER_IMAGE_URI_AWS}-query:${VERSION} ./src/query/

	@echo "Building Docker Image: ${DOCKER_IMAGE_URI_AWS}-command:${VERSION} "
	docker buildx build --platform linux/amd64 --network host --rm -t ${DOCKER_IMAGE_URI_AWS}-command:${VERSION} ./src/command/

docker-delivery:
	aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin $(ECR_LOCATION)
	aws ecr create-repository --repository-name ${PROJECT_NAME}-query 2>/dev/null || true
	aws ecr create-repository --repository-name ${PROJECT_NAME}-command 2>/dev/null || true
	docker push ${DOCKER_IMAGE_URI_AWS}-query:${VERSION}
	docker push ${DOCKER_IMAGE_URI_AWS}-command:${VERSION}

