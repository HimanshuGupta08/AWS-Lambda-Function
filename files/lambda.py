# Timer Trigger

import boto3

# Replace these with your actual values
lambda_function_name = "ExampleLambdaFunction"
rule_name = "lambda-schedule-rule"
schedule_expression = "cron(0 12 * * ? *)"  # Replace with your desired cron expression

# Create a CloudWatch Events client
cloudwatch_events = boto3.client('events')

# Create the rule with the scheduled expression
response = cloudwatch_events.put_rule(
    Name=rule_name,
    ScheduleExpression=schedule_expression,
    State='ENABLED'
)

# Add a target to the rule to trigger your Lambda function
cloudwatch_events.put_targets(
    Rule=rule_name,
    Targets=[
        {
            'Id': '1',
            'Arn': f'arn:aws:lambda:us-east-1:528219205020:function:{lambda_function_name}'
        }
    ]
)