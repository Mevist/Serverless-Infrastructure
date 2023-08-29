output "game_messaging_name" {
  value = aws_lambda_function.game_messaging.function_name
}

output "matchmaking_game_arn" {
  value = aws_lambda_function.matchmaking_game.arn
}

output "join_game_arn" {
  value = aws_lambda_function.join_game.arn
}

output "disconnect_game_arn" {
  value = aws_lambda_function.disconnect_game.arn
}