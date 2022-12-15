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

### Cloud

### IaaC

This components aims to be fully automated using terraform as IaaC tool and taking advantage of their comunity modules.

To work in terraform for production purposes involves to have an s3 bucket to store the tf_state file remotly and a dynamo db table for lockings. Due to the target of this project, this step is skiped.

For this component, following terraform aws comunity modules are used:
 - [aws lambdas](https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest)
 - [aws api-gateway v2](https://registry.terraform.io/modules/terraform-aws-modules/apigateway-v2/aws/latest)

### Python

## CI/CD

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

make aws-lambda-delivery

```

To provision the infrastruture, you can run:

```bash

make aws-lambda-provision

```

## References

## Author

* javigs82 [github](https://github.com/javigs82/)
