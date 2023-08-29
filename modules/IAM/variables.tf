variable "policy_attachments" {
  type = map(string)
  default = {
    "LambdaExec"            =  "arn:aws:iam::817480058031:policy/service-role/AWSLambdaBasicExecutionRole-6cd33fef-f37e-4a44-b682-6e0577fe5c4d",
    "ApiGatewayAdmin"       =  "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator",
    "ApiGatewayInvoke"      =  "arn:aws:iam::aws:policy/AmazonAPIGatewayInvokeFullAccess",
    "DynamoDBAccess"        =   "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
    "CloudWatchLogsAccess"  = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "LambdaSQSExecution"    = "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole"
    "LambdaAccess"          = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
  }
}