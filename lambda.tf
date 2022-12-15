module "lambda_query" {
  source                         = "./modules/lambda"
  function_name                  = "${var.cmp_name}-query"
  function_version               = var.cmp_version
  apigatewayv2_api_execution_arn = module.api_gateway.apigatewayv2_api_execution_arn
  providers = {
    aws = aws
  }
}

module "lambda_command" {
  source           = "./modules/lambda"
  function_name    = "${var.cmp_name}-command"
  function_version = var.cmp_version
  apigatewayv2_api_execution_arn = module.api_gateway.apigatewayv2_api_execution_arn
  providers = {
    aws = aws
  }
}

