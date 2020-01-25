terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = ">= 2.27"
  region  = var.region
}

data "aws_caller_identity" "current" {}

module "ecr" {
  source      = "../../"
  name_prefix = var.name_prefix

  trusted_accounts = [
    data.aws_caller_identity.current.account_id
  ]

  tags = {
    environment = "dev"
    terraform   = "True"
  }
}
