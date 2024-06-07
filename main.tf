# Creating a lambda resource for AWS
resource "aws_lambda_function" "lambda_func" {
  function_name = var.lambda_function_name
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  filename      = var.lambda_deployment_package
  role          = aws_iam_role.lambda_execution_role.arn
  tags = var.lambda_tags
}

# Creating the policy for lambda with admin access
resource "aws_iam_policy" "lambda_custom_policy" {
  name        = var.lambda_policy_name
  description = "Custom IAM policy for Lambda function with broad permissions"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "lambda:InvokeFunction",
          "lambda:InvokeAsync",
          "lambda:CreateFunction",
          "lambda:DeleteFunction",
          "lambda:GetFunction",
          "lambda:UpdateFunctionCode",
          "lambda:UpdateFunctionConfiguration",
          "lambda:CreateEventSourceMapping",
          "lambda:DeleteEventSourceMapping",
          "lambda:ListEventSourceMappings",
          "lambda:CreateAlias",
          "lambda:DeleteAlias",
          "lambda:GetAlias",
          "lambda:UpdateAlias",
          "lambda:ListAliases",
          "lambda:GetFunctionConfiguration",
          "lambda:CreateCodeSigningConfig",
          "lambda:UpdateCodeSigningConfig",
          "lambda:GetCodeSigningConfig",
          "lambda:ListCodeSigningConfigs",
          "lambda:DeleteCodeSigningConfig",
          "lambda:GetAccountSettings",
          "lambda:GetFunctionEventInvokeConfig",
          "lambda:PutFunctionEventInvokeConfig",
          "lambda:DeleteFunctionEventInvokeConfig",
          "lambda:ListFunctions",
          "lambda:ListTags",
          "lambda:ListLayers",
          "lambda:PublishLayerVersion",
          "lambda:DeleteLayerVersion",
          "lambda:GetLayerVersion",
          "lambda:ListVersionsByFunction",
          "lambda:GetLayerVersionPolicy",
          "lambda:GetLayerVersionPolicy",
          "lambda:GetFunctionPolicy",
          "lambda:AddPermission",
          "lambda:RemovePermission",
          "lambda:TagResource",
          "lambda:UntagResource",
          "events:PutRule",
          "events:PutTargets",
          "events:ListTargetsByRule"
        ]
        Resource = "*"
      },
    ]
  })
}

# Creating the role
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_iam_role_creation"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

# Policy attachment
resource "aws_iam_policy_attachment" "lambda_custom_policy_attachment" {
  name       = "attachment_lambda_custom_policy"
  policy_arn = aws_iam_policy.lambda_custom_policy.arn
  roles      = [aws_iam_role.lambda_execution_role.name]
}

# # Creating KMS and its policy
# resource "aws_kms_key" "example_key" {
#   description             = var.key_description
#   deletion_window_in_days = 30
#   policy = <<-EOT
#   {
#   "Version": "2012-10-17",
#   "Id": "key-default-1",
#   "Statement": [
#     {
#       "Sid": "Enable IAM User Permissions",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::YOUR_ACCOUNT_ID:root"
#       },
#       "Action": "kms:*",
#       "Resource": "*"
#     }
#   ]
# }
# EOT

#   tags = {
#     Name = "ExampleKMSKey"
#   }
# }

# resource "aws_kms_alias" "example_alias" {
#   name          = var.key_alias
#   target_key_id = aws_kms_key.example_key.key_id
# }
