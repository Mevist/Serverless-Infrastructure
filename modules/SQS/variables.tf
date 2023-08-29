variable config {
    description = "The default configuration for SQS"
    type = map(number)
    default = {
        "message_retention_seconds"     = 60,
        "visibility_timeout_seconds"    = 70
    }
}