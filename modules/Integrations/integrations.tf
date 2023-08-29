data "aws_region" "current" {}

output "region" {
  value = data.aws_region.current.name
}

# # # # # # # # # # # # # # # # # # # # #
resource "aws_apigatewayv2_integration" "sqs_integration" {
  api_id                      = var.api_id
  integration_type            = "AWS"
  integration_method          = "POST" 
  content_handling_strategy   = "CONVERT_TO_TEXT"
  integration_uri             = "arn:aws:apigateway:${data.aws_region.current.name}:sqs:path/${var.account_id}/${var.sqs_name}" 
  credentials_arn             = var.sqs_role_arn

 # ---- Neccesary for sqs to read messages pushed by api gateway websocket API ----
  passthrough_behavior        = "NEVER"
  request_parameters          = {
    "integration.request.header.Content-Type": "'application/x-www-form-urlencoded'"
  }
  request_templates           = {
    "application/json": "Action=SendMessage&MessageBody=$util.urlEncode($input.body)"
  }
}

resource "aws_apigatewayv2_route" "sqs_route" {
  api_id          = var.api_id
  route_key       = "OnMessage"
  target          = "integrations/${aws_apigatewayv2_integration.sqs_integration.id}"
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn      = var.sqs_arn
  function_name         = var.game_messaging_function_name
  enabled               = true
}
# # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # #
resource "aws_apigatewayv2_integration" "matchmaking_integration" {
  api_id                      = var.api_id
  integration_type            = "AWS_PROXY"
  content_handling_strategy   = "CONVERT_TO_TEXT"
  integration_uri             = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${var.matchmaking_game_arn}/invocations"
  credentials_arn             = var.game_server_role_arn
}

resource "aws_apigatewayv2_route" "matchmaking_route" {
  api_id          = var.api_id
  route_key       = "MatchMaking"
  target          = "integrations/${aws_apigatewayv2_integration.matchmaking_integration.id}"
}
# # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # #
resource "aws_apigatewayv2_integration" "connect_integration" {
  api_id                      = var.api_id
  integration_type            = "AWS_PROXY"
  content_handling_strategy   = "CONVERT_TO_TEXT"
  integration_uri             = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${var.join_game_arn}/invocations"
  credentials_arn             = var.game_server_role_arn
}

resource "aws_apigatewayv2_route" "connect_route" {
  api_id          = var.api_id
  route_key       = "$connect"
  target          = "integrations/${aws_apigatewayv2_integration.connect_integration.id}"
}
# # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # #
resource "aws_apigatewayv2_integration" "disconnect_integration" {
  api_id                      = var.api_id
  integration_type            = "AWS_PROXY"
  content_handling_strategy   = "CONVERT_TO_TEXT"
  integration_uri             = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${var.disconnect_game_arn}/invocations"
  credentials_arn             = var.game_server_role_arn
}

resource "aws_apigatewayv2_route" "disconnect_route" {
  api_id          = var.api_id
  route_key       = "$disconnect"
  target          = "integrations/${aws_apigatewayv2_integration.disconnect_integration.id}"
}
# # # # # # # # # # # # # # # # # # # # #