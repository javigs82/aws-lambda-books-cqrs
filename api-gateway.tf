module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "2.2.1"

  name          = var.cmp_name
  description   = "API Gateway ${var.cmp_name}"
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  create_api_domain_name = false

  default_stage_access_log_destination_arn = aws_cloudwatch_log_group.logs.arn
  default_stage_access_log_format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"

  default_route_settings = {
    detailed_metrics_enabled = true
    throttling_burst_limit   = 100
    throttling_rate_limit    = 100
  }

  integrations = {
    "ANY /" = {
      lambda_arn             = module.lambda_query.lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }
    "GET /v1/books/{id}" = {
      lambda_arn             = module.lambda_query.lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }
    "POST /v1/books" = {
      lambda_arn               = module.lambda_command.lambda_function_arn
      payload_format_version   = "2.0"
      authorization_type       = "JWT"
      timeout_milliseconds     = 12000
      authorizer_id            = aws_apigatewayv2_authorizer.auth0.id
      throttling_rate_limit    = 80
      throttling_burst_limit   = 40
      detailed_metrics_enabled = true
    }

    "$default" = {
      lambda_arn = module.lambda_query.lambda_function_arn
    }
  }

  tags = {
    Name = var.cmp_name
  }
}

resource "aws_cloudwatch_log_group" "logs" {
  name = "/aws/apigw/${var.cmp_name}"
  retention_in_days = var.cloudwatch_logs_retention_in_days
}

resource "aws_apigatewayv2_authorizer" "auth0" {
  api_id           = module.api_gateway.apigatewayv2_api_id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "auth0"

  jwt_configuration {
    audience = ["https://auth0-jwt-authorizer"]
    issuer   = var.api_gateway_jwt_authorizer_issuer
  }
}