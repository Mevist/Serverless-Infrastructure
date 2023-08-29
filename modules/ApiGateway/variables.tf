variable "config_route" {
  description = "Configuration settings for the apigateway route."
  type        = map(any)
  default = {
    throttling_burst_limit    = 5000
    throttling_rate_limit     = 10000
    data_trace_enabled        = true
    detailed_metrics_enabled  = true
  }
}
