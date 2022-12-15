data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_ecr_repository" "this" {
  name = var.function_name
}

data "aws_ecr_image" "this" {
  repository_name = var.function_name
  image_tag       = var.function_version
}

module "lambda_function_container_image" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.7.1"

  function_name              = var.function_name
  description                = "aws lambda for ${var.function_name}"
  create_lambda_function_url = false # error if true


  architectures = ["x86_64"]
  #compatible_architectures = ["x86_64","arm64"]

  attach_cloudwatch_logs_policy     = true
  cloudwatch_logs_retention_in_days = var.cloudwatch_logs_retention_in_days
  tracing_mode                      = "Active"

  authorization_type = "NONE" #check
  cors               = {}     # check

  build_in_docker = false # do it externaly as part of app ci/cd
  create_package  = false
  publish         = true
  # using the sha256, lambda is able to publish new images
  image_uri               = "${data.aws_ecr_repository.this.repository_url}@${data.aws_ecr_image.this.id}"
  ignore_source_code_hash = true
  package_type            = "Image"

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service    = "apigateway"
      source_arn = "${var.apigatewayv2_api_execution_arn}/*/*"
    }
  }
}