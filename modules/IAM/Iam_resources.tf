data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com","apigateway.amazonaws.com"]
    }
  }
  
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["xray.amazonaws.com"]
    }
    sid = "Statement1"
  }
}

resource "aws_iam_role" "game_server_role" {
  name                  = "game-server-role"
  assume_role_policy    = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy_attachment" "game_server_role_attachments"{
    for_each    = var.policy_attachments
    name        = "Attachment-$[each.key]"
    roles       = [aws_iam_role.game_server_role.name]
    policy_arn  = each.value

    lifecycle {
      ignore_changes = [users,roles]
    }
}

# # # # # # # # # # # # # # # # # # # # #

data "aws_iam_policy_document" "assume_sqs_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sqs.amazonaws.com","apigateway.amazonaws.com"]
    }
  }
}

variable "sqs_policy_attachments" {
  type = map(string)
  default = {
    InputsQueueAccesPolicy = "arn:aws:iam::817480058031:policy/InputsQueueAccesPolicy"
    PushToCloudWatchLogs   = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  }
}

resource "aws_iam_role" "SQS_role"{
  name      = "APIGateWayQueueAccesRole"
  assume_role_policy = data.aws_iam_policy_document.assume_sqs_role.json
}

resource aws_iam_policy_attachment "SQS_role_attachments_1"{
  for_each    = var.sqs_policy_attachments
  name        = "SQS_Attachment-$[each.key]"
  roles       = [aws_iam_role.SQS_role.name]
  policy_arn  = each.value

  lifecycle {
      ignore_changes = [users,roles]
    }
}