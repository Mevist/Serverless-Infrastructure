variable "config_route_throttle" {
  description = "Configuration settings for the apigateway throttling."
  type        = map(number)
  default = {
    throttling_burst_limit    = 5000,
    throttling_rate_limit     = 10000
  }
}


variable "config_route_monitoring" {
  description = "Configuration settings for the apigateway route monitoring."
  type        = map(bool)
  default = {
    data_trace_enabled        = true,
    detailed_metrics_enabled  = true
  }
}

