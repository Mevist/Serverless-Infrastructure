terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-central-1"
}


data "aws_region" "current" {}

output "region" {
  value = data.aws_region.current.name
}

module "IAM_roles" {
    source = "./modules/IAM"
}

module "Lambdas" {
    source = "./modules/Lambdas"

    game_server_arn = module.IAM_roles.game_server_role_arn
}

