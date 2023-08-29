resource "aws_sqs_queue" "game_messaging_queue" {
  name          = "InputsQueue"
  message_retention_seconds = var.config["message_retention_seconds"]
  visibility_timeout_seconds = var.config["visibility_timeout_seconds"]
}