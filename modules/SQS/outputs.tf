output "sqs_arn" {
  value = aws_sqs_queue.game_messaging_queue.arn
}

output "sqs_name" {
  value = aws_sqs_queue.game_messaging_queue.name
}