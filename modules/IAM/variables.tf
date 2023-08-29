variable "account_id" {
    description = "Account id - set it in main.tf when calling module"
}

variable "policy_attachments" {
  type = map(string)
  default = {
    #"LambdaExec"            =  "default", #will be exectued properly in iam_resources using account id may need to add it later
    "ApiGatewayAdmin"       =  "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator",
    "ApiGatewayInvoke"      =  "arn:aws:iam::aws:policy/AmazonAPIGatewayInvokeFullAccess",
    "DynamoDBAccess"        =   "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
    "CloudWatchLogsAccess"  = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "LambdaSQSExecution"    = "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole"
    "LambdaAccess"          = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
  }
}

variable "sqs_policy_attachments" {
  type = map(string)
  default = {
    InputsQueueAccesPolicy = "placeholder"
    PushToCloudWatchLogs   = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  }
}
# WIP
#here i might need to create new policies depending on what is needed