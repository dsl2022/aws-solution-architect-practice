resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.detach_reattach_eni_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_state_change.arn
}

resource "aws_cloudwatch_event_rule" "ec2_state_change" {
  name        = "ec2-state-change"
  description = "EC2 instance state change"

  event_pattern = jsonencode({
    "source" : ["aws.ec2"],
    "detail-type" : ["EC2 Instance State-change Notification"],
    "detail" : {
      "state" : ["stopped", "terminated", "stopping", "shutting-down","started"], # specify the state changes you want to monitor
      "instance-id" : [aws_instance.primary_instance.id] # target specific instance
    }
  })

  depends_on = [aws_instance.primary_instance]
}


resource "aws_cloudwatch_event_target" "invoke_lambda" {
  rule      = aws_cloudwatch_event_rule.ec2_state_change.name
  target_id = "InvokeLambdaFunction"
  arn       = aws_lambda_function.detach_reattach_eni_lambda.arn
}

