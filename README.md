# Serverless Infrastructure [WIP]
## Brief description
Infrastrure created in need for creating serverless comunication protocol for multiplayer games based on inputs exchange.
It was created in AWS cloud and consists API Gateway, couple of lambda functions which all but one are integrated with API gateway directly. Lambda function responsive for handling players inputs is integrated with SQS to bescallable and ensure none message will be lost.

Modules:
 * ApiGateway     - Websocket API
 * IAM            - Roles and policies for resources.
 * Lambdas        - Functions for creating connecting/disconnecting websockets, joining game and exchange messages. Details here:
    https://github.com/Mevist/AWS-Lambdas-Serverless/tree/ver2
 * SQS            - Queueing players inputs
 * DynamoDB       - Created seassions of games, mainly storing game UUIDs and playersIDs
 * Integrations   - Resource integrations, Mostly, ApiGateway -> Lambda, expect one ApiGateway -> SQS -> Lambda

## Usage
USED ONLY FOR TESTING PURPOSES

_Before using make sure your roles has neccesary policies attached. In this exmaple there is one role attached for every resource. IT'S NOT PRACTICE TO FOLLOW. Try to apply least-privilege permissions [TODO]_
https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html


Terraform version used: v.1.5.4 on WIN 10

1. While in project directory and logged as authorized user init modules
```
terraform init
```
2. Check for errors
```
terraform plan
```
3. Lastly
```
terraform apply
```
