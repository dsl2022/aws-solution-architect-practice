resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name = "/aws/lambda/firehose_lambda_processor"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "firehose_log_group" {
  name = "/aws/kinesisfirehose/terraform-kinesis-firehose-extended-s3-test-stream"
  retention_in_days = 14
}
