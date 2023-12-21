resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.detach_reattach_eni_lambda.function_name}"
  retention_in_days = 14  # Set the retention policy (in days)
}
