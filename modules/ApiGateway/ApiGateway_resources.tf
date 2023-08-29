resource "aws_apigatewayv2_api" "game-websocket-api-1" {
  name            = "game-websocket-api-1"
  protocol_type   = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
}

resource "aws_apigatewayv2_stage" "main_stage" {
  api_id        = aws_apigatewayv2_api.game-websocket-api-1.id
  name          = "main"
  auto_deploy   = true
  default_route_settings {
    throttling_burst_limit    = var.config_route_throttle["throttling_burst_limit"]
    throttling_rate_limit     = var.config_route_throttle["throttling_rate_limit"]
    data_trace_enabled        = var.config_route_monitoring["data_trace_enabled"]
    detailed_metrics_enabled  = var.config_route_monitoring["detailed_metrics_enabled"]
  }
}