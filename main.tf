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
  region = var.infrastructure_region
}

data "aws_caller_identity" "current" {}

output "account_id" {
  description = "The AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

module "IAM_roles" {
    source = "./modules/IAM"

    #Inputs
    account_id = data.aws_caller_identity.current.account_id
}

module "ApiGateway" {
    source = "./modules/ApiGateWay"
}

module "SQS" {
    source = "./modules/SQS"
}

module "Lambdas" {
    source = "./modules/Lambdas"

    game_server_arn = module.IAM_roles.game_server_role_arn
}

module "DynamoDB" {
    source = "./modules/DynamoDB"
}

module "Integrations" {
    source = "./modules/Integrations"

    #Inputs
    account_id = data.aws_caller_identity.current.account_id

    api_id = module.ApiGateway.api_id
    sqs_arn = module.SQS.sqs_arn
    sqs_name = module.SQS.sqs_name

    game_server_role_arn = module.IAM_roles.game_server_role_arn
    sqs_role_arn = module.IAM_roles.sqs_role_arn
    
    game_messaging_function_name = module.Lambdas.game_messaging_name
    matchmaking_game_arn = module.Lambdas.matchmaking_game_arn
    join_game_arn = module.Lambdas.join_game_arn
    disconnect_game_arn = module.Lambdas.disconnect_game_arn
}




