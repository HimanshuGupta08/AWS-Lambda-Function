aws_region = "us-east-1"
lambda_function_name = "Lambda-Function-Example"
lambda_handler = "lambda.lambda_handler"
lambda_runtime = "python3.11"
lambda_deployment_package = "files.zip"
lambda_role_name = "Lambda-Execution-Role-Example"
lambda_policy_name = "Custom-Lambda-Policy"
lambda_tags = {
  name = "himanshu.gupta@cloudeq.com",
  project = "CEQ-Governance",
  Purpose = "Testing"
}

lambda_environment_variables = {
  KEY1 = "VALUE1"
  KEY2 = "VALUE2"
}
