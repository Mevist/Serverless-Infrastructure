resource "aws_dynamodb_table" "example" {
  name           = "game-session"
  billing_mode   = var.config["billing_mode"]
  read_capacity  = var.config["read_capacity"]
  write_capacity = var.config["write_capacity"]
  hash_key       = "uuid"

  attribute {
    name = "uuid"
    type = "S"
  }
}
