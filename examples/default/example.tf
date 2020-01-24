provider "aws" {
  region = "eu-west-1"
}

data "aws_vpc" "main" {
  default = true
}

data "aws_subnet_ids" "main" {
  vpc_id = data.aws_vpc.main.id
}

module "ecr" {
  source      = "../../"
  name_prefix = "example-repo"

  trusted_accounts = [
    "111122223333", # test account A
    "444455556666", # test account B
    "777788889999", # test account C
  ]
}
