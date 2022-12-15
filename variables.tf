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


