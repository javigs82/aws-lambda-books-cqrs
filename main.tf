provider "aws" {
  region = var.aws_region
  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true

  # skip_requesting_account_id should be disabled to generate valid ARN in apigatewayv2_api_execution_arn
  skip_requesting_account_id = false

  assume_role {
    # This is a variable based on the AWS account
    role_arn     = var.role_arn
    session_name = "terraform"
  }
}
