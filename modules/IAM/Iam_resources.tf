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
# arn:aws:iam::${var.account_id}:policy/service-role/AWSLambdaBasicExecutionRole-6cd33fef-f37e-4a44-b682-6e0577fe5c4d
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
resource "aws_iam_role" "SQS_role"{
  name      = "APIGateWayQueueAccesRole"
  assume_role_policy = data.aws_iam_policy_document.assume_sqs_role.json
}

resource aws_iam_policy_attachment "SQS_role_attachments_1"{
  for_each    = var.sqs_policy_attachments
  name        = "SQS_Attachment-$[each.key]"
  roles       = [aws_iam_role.SQS_role.name]
    # condition added to add specific policy based on account id
  policy_arn  = each.key == "InputsQueueAccesPolicy" ? "arn:aws:iam::${var.account_id}:policy/InputsQueueAccesPolicy" : each.value

  lifecycle {
      ignore_changes = [users,roles]
    }
}