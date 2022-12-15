variable "function_name" {
  description = "Name of the current lambda"
}

variable "function_version" {
  description = "Version of the current component"
}

variable "cloudwatch_logs_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group"
  default     = 0
}

variable "apigatewayv2_api_execution_arn" {
  description = "the api gateway execution arn to allow executions"
}


