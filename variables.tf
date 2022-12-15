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


variable "jwt_authorizer" {
  description = "JWT Authorizer Object"
  type = object({
    name             = string
    type             = string
    identity_sources = list(string)
    audience         = list(string)
    issuer           = string
  })
  default = {
    name             = "auth0"
    type             = "JWT"
    identity_sources = ["$request.header.Authorization"]
    audience         = ["https://auth0-jwt-authorizer"]
    issuer           = "https://dev-jnunrkz8y4jtwkaz.eu.auth0.com/" #important last slash
  }
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


