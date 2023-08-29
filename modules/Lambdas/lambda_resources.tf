data "archive_file" "lambda-game_messaging_zip" {
 type        = "zip"
 source_file = var.lambda_source_files["game_messaging"]
 output_path = var.lambda_output_files["game_messaging"]
}

data "archive_file" "lambda-matchmaking_game_zip" {
 type        = "zip"
 source_file = var.lambda_source_files["matchmaking_game"]
 output_path = var.lambda_output_files["matchmaking_game"]
}

data "archive_file" "lambda-join_game_zip" {
 type        = "zip"
 source_file = var.lambda_source_files["join_game"]
 output_path = var.lambda_output_files["join_game"]
}

data "archive_file" "lambda-disconnect_game_zip" {
 type        = "zip"
 source_file = var.lambda_source_files["disconnect_game"]
 output_path = var.lambda_output_files["disconnect_game"]
}

resource "aws_lambda_function" "game_messaging" {
  depends_on = [data.archive_file.lambda-game_messaging_zip]
  function_name = var.game_messaging_config["function_name"]
  description   = "Main function for messages handling"
  handler       = var.game_messaging_config["handler"]
  runtime       = var.config["lambda_runtime"]
  timeout       = var.config["lambda_timeout"]
  memory_size   = var.config["memory_size"]

  filename          =  var.lambda_output_files["game_messaging"]
  source_code_hash  = filebase64sha256(var.lambda_output_files["game_messaging"])
  role              = var.game_server_arn
}

resource "aws_lambda_function" "matchmaking_game" {
  depends_on = [data.archive_file.lambda-matchmaking_game_zip]

  function_name = var.matchmaking_game_config["function_name"]
  description   = "This function handles request for creating new game and players joining lobbies"
  handler       = var.matchmaking_game_config["handler"]
  runtime       = var.lambda_runtime
  timeout       = var.lambda_timeout

  filename          = var.lambda_output_files["matchmaking_game"]
  source_code_hash  = filebase64sha256(var.lambda_output_files["matchmaking_game"])
  role              = var.game_server_arn
}

resource "aws_lambda_function" "join_game" {
  depends_on = [data.archive_file.lambda-matchmaking_game_zip]

  function_name = var.join_game_config["function_name"]
  description   = "This function establish connection for websockets."
  handler       = var.join_game_config["handler"]
  runtime       = var.lambda_runtime
  timeout       = var.lambda_timeout

  filename          = var.lambda_output_files["join_game"]
  source_code_hash  = filebase64sha256(var.lambda_output_files["join_game"])
  role              = var.game_server_arn
}

resource "aws_lambda_function" "disconnect_game" {
  depends_on = [data.archive_file.lambda-disconnect_game_zip]

  function_name = var.disconnect_game_config["function_name"]
  description   = "Function for disconnecting websockets from AWS"
  handler       = var.disconnect_game_config["handler"]
  runtime       = var.lambda_runtime
  timeout       = var.lambda_timeout


  filename          =  var.lambda_output_files["disconnect_game"]
  source_code_hash  = filebase64sha256(var.lambda_output_files["disconnect_game"])
  role              = var.game_server_arn
}