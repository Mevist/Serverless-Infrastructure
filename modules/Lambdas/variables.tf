variable "lambda_source_files" {
  description = "Map of source files for Lambda functions"
  type = map(string)
  default = {
    "game_messaging"   = "D:\\Programy\\GitHub Repositories\\LambdaFunctionsPyCharm\\game_messaging.py",
    "matchmaking_game" = "D:\\Programy\\GitHub Repositories\\LambdaFunctionsPyCharm\\matchmaking_game.py",
    "join_game"        = "D:\\Programy\\GitHub Repositories\\LambdaFunctionsPyCharm\\join_game.py",
    "disconnect_game"  = "D:\\Programy\\GitHub Repositories\\LambdaFunctionsPyCharm\\disconnect_game.py"
  }
}

variable "lambda_output_files" {
  description = "Map of source files for Lambda functions"
  type = map(string)
  default = {
    "game_messaging"   = "D:\\Programy\\terraform\\AWS-project\\Serverless-Infrastructure\\python\\game_messaging.zip",
    "matchmaking_game" = "D:\\Programy\\terraform\\AWS-project\\Serverless-Infrastructure\\python\\matchmaking_game.zip",
    "join_game"        = "D:\\Programy\\terraform\\AWS-project\\Serverless-Infrastructure\\python\\join_game.zip",
    "disconnect_game"  = "D:\\Programy\\terraform\\AWS-project\\Serverless-Infrastructure\\python\\disconnect_game.zip"
  }
}

variable "output_directory" {
  description = "Directory to store the zipped Lambda functions"
  default = "D:\\Programy\\terraform\\AWS-project\\Serverless-Infrastructure\\python"
}

variable "game_server_arn" {
    description = "The basic role used for resources in AWS, search definition in IAM module"
}

variable "lambda_runtime" {
  description = "Runtime for the Lambda function"
  default     = "python3.9"
}

variable "lambda_timeout" {
  description = "Timeout for the Lambda function"
  default     = 3
}

variable "config" {
    description = "The basic configuration for lambda functions"
    type = map(string)
    default = {
      "lambda_runtime"  = "python3.10",
      "lambda_timeout"  = 3,
      "memory_size"     = 512
    }
}

variable "game_messaging_config" {
    description = "The default values for game messaging function"
    type = map(string)
    default = {
        "function_name" = "game_messaging",
        "handler"       = "game_messaging.game_messaging_handler"
    }
}

variable "matchmaking_game_config" {
    description = "The default values for matchmaking function"
    type = map(string)
    default = {
        "function_name" = "matchmaking_game",
        "handler"       = "matchmaking_game.matchmaking_game_handler"
    }
}

variable "join_game_config" {
    description = "The default values for join game function"
    type = map(string)
    default = {
        "function_name" = "join_game",
        "handler"       = "join_game.join_game_handler"
    }
}

variable "disconnect_game_config" {
    description = "The default values for disconnect game function"
    type = map(string)
    default = {
        "function_name" = "disconnect_game",
        "handler"       = "disconnect_game.disconnect_game_handler"
    }
}