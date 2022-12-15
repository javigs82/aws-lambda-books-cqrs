# Books CQRS on top of AWS Lambda

Example of how to deploy an AWS lambda as IaaC , written in terrafom and orchestrated by makefiles to provide more extensibily and reproductivily in terms of ci/cd.

The repo aims to define a CQRS on top of AWS Lambdas and API Gateway, containing
two services: The command and The query writen in python and delivered in Docker to ECR.

## Requirements

Following requirements are a must
 - HTTP Interface
 - Separation of concerns: Command and Query Services
 - Use of AWS Lambdas on top of Docker
 - IaaC: All infra as a code
 - Logging: On top of CloudWatch
 - Auth: On top of API Gateway
 - Continuous Integration and Delivery: ECR
 - Deployment: One click deployment on top of make commands


### Assumptions

AS this repository try to show how to implement things, some points need
to be assumed:

  - AWS Authentication: In order to deploy this component, devops must be properly authneticated in AWS. At the time of written, [aws-vault](https://github.com/99designs/aws-vault) is the current solution.

  - Terraform remote state is out of the scope. For this playground, local state is mandatory. Please not that infra must be destroyed at the end of the work.


## Architecture

Following Image describes the architecture implemented in this component.


### IaaC

This components aims to be fully automated using terraform as IaaC tool and taking advantage of their comunity modules.

To work in terraform for production purposes involves to have an s3 bucket to store the tf_state file remotly and a dynamo db table for lockings. Due to the target of this project, this step is skiped.

For this component, following terraform aws comunity modules are used:
 - [aws lambdas](https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest)
 - [aws api-gateway v2](https://registry.terraform.io/modules/terraform-aws-modules/apigateway-v2/aws/latest)

### Identity Provider

This projects uses OIDC and Oauth as Identity Standar integrated in AWS on top
of [Api Gateway JWT Authorizers](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-jwt-authorizer.html). 

As identity provider, [Auth0](https://auth0.com/) is the preferred one.

Check the issuer here:

> https://dev-jnunrkz8y4jtwkaz.eu.auth0.com/.well-known/openid-configuration

## CI/CD

TBC

## How to run

In order to run this project in localhost, developers must be authenticated in aws.
For more info, please visit aws offcial doc.

A set of `ENV_VARS` needed for this projtec are defined in the Makefile at root folder level.
Some of them can be overwriten to comply with any multi environment requirement.

### Dependecies
In order to be able to execute commands, following dependencies must be properly installed.

 - docker
 - python 3.9
 - pip
 - terraform 1.2.8
    
### Main Commands

To publish a new container in ECR, you can run:

```bash

make docker-delivery

```

To provision the infrastruture, you can run:

```bash

make terraform-apply

```

## References

 - https://auth0.com/blog/securing-aws-http-apis-with-jwt-authorizers/

## Author

* javigs82 [github](https://github.com/javigs82/)
