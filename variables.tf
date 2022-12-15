variable "cmp_name" {
  description = "Name of the current component"
}

variable "cmp_version" {
  description = "Version of the current component"
}

variable "aws_region" {
  description = "Region to deploy resources"
}

variable "role_arn" {
  description = "Role to be used by the cd server"
  default     = ""
}

variable "cloudwatch_logs_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group"
  default     = 0
}

variable "api_gateway_jwt_authorizer_issuer" {
  description = "This is the OIDC issuer"
  default     = "https://dev-jnunrkz8y4jtwkaz.eu.auth0.com/"
}

variable "routes" {
  description = "List of object to parametrize Routes"
  type = list(
    object(
      {
        http_verb              = string
        public_uri             = string
        private_uri            = string
        timeout_milliseconds   = number
        lambda_name            = string
        authorizer_name        = string
        throttling_burst_limit = number
        throttling_rate_limit  = number
        payload_format_version = string
      }
    )
  )
  default = []
}


