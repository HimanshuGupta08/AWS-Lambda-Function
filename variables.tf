variable "aws_region" {
  description = "AWS region where the resources will be created."
}

variable "lambda_function_name" {
  description = "Name of the Lambda function."
}

variable "lambda_handler" {
  description = "Handler for the Lambda function (e.g., index.handler)."
}

variable "lambda_runtime" {
  description = "Runtime for the Lambda function (e.g., nodejs14.x, python3.8, etc.)."
}

variable "lambda_deployment_package" {
  description = "Path to the Lambda deployment package (zip or jar file)."
}

variable "lambda_role_name" {
  description = "Name of the IAM role for Lambda execution."
}

variable "lambda_environment_variables" {
  description = "Environment variables for the Lambda function (map type)."
  type        = map(string)
}

variable "lambda_policy_name" {
  description = "Policy name for the Lambda function."
}

variable "lambda_tags" {
  description = "Tags for lambda function"
}

