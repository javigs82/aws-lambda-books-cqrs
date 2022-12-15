provider "aws" {
  region = var.aws_region

  assume_role {
    # This is a variable based on the AWS account
    role_arn     = var.role_arn
    session_name = "terraform"
  }
}
