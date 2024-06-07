import boto3

# Replace these with your actual values
lambda_function_name = "ExampleLambdaFunction"
api_name = "MyApi"
stage_name = "v1"

# Create an API Gateway client
api_gateway = boto3.client('apigateway')

# Create the API
response = api_gateway.create_rest_api(
    name=api_name,
    description='My API Gateway for Lambda trigger'
)

# Get the API ID
api_id = response['id']

# Create a resource for the API
resource = api_gateway.create_resource(
    restApiId=api_id,
    parentId='/'  # Parent resource is the root of the API
)

# Get the resource ID
resource_id = resource['id']

# Create a POST method for the resource
api_gateway.put_method(
    restApiId=api_id,
    resourceId=resource_id,
    httpMethod='POST',
    authorizationType='NONE'  # No authorization required for simplicity, consider using AWS_IAM for production
)

# Set the Lambda function as the target for the POST method
api_gateway.put_integration (
    restApiId=api_id,
    resourceId=resource_id,
    httpMethod='POST',
    type='AWS',
    integrationHttpMethod='POST',
    uri=f'arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:YOUR_ACCOUNT_ID:function:{lambda_function_name}/invocations'
)

# Deploy the API to create a new stage
api_gateway.create_deployment(
    restApiId=api_id,
    stageName=stage_name
)

# Get the URL of the API Gateway endpoint
endpoint_url = f'https://{api_id}.execute-api.us-east-1.amazonaws.com/{stage_name}/{resource_id}'

print(f"API Gateway URL: {endpoint_url}")
