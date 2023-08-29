output "game_server_role_arn" {
    value = aws_iam_role.game_server_role.arn
}

output "sqs_role_arn" {
    value = aws_iam_role.SQS_role.arn
}