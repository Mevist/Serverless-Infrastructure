variable "api_id" {
  description = "API Gateway V2 API ID."
}

variable "account_id" {
    description = "Account id - set it in main.tf when calling module"
}

variable "sqs_arn" {
  description = "ARN of the SQS queue."
  type        = string
}

variable sqs_name {
    description = "The name of the sqs"
    type = string
}

variable "game_server_role_arn" {
  description = "ARN of the IAM role for the game server."
  type        = string
}

variable "sqs_role_arn" {
  description = "ARN of the IAM role for SQS."
  type        = string
}

variable "game_messaging_function_name" {
  description = "function name of the game messaging lambda function."
  type        = string
}

variable "matchmaking_game_arn" {
  description = "ARN of the matchmaking lambda function."
  type        = string
}

variable "join_game_arn" {
  description = "ARN of the join game lambda function."
  type        = string
}

variable "disconnect_game_arn" {
  description = "ARN of the disconnect game lambda function."
  type        = string
}