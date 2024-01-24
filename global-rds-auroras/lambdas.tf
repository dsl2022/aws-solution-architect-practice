data "archive_file" "lambda_write_to_primary" {
  type        = "zip"
  source_file = "${path.module}/write_to_primary/index.js"
  output_path = "${path.module}/write_to_primary.zip"
}

data "archive_file" "lambda_read_from_secondary" {
  type        = "zip"
  source_file = "${path.module}/read_from_secondary/index.js"
  output_path = "${path.module}/read_from_secondary.zip"
}

resource "aws_lambda_function" "write_to_primary_lambda" {
  function_name    = "write_to_primary"
  filename         = data.archive_file.lambda_write_to_primary.output_path
  source_code_hash = data.archive_file.lambda_write_to_primary.output_base64sha256
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  role             = aws_iam_role.lambda_execution_role.arn
}

resource "aws_lambda_function" "read_from_secondary_lambda" {
  function_name    = "read_from_secondary"
  filename         = data.archive_file.lambda_read_from_secondary.output_path
  source_code_hash = data.archive_file.lambda_read_from_secondary.output_base64sha256
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  role             = aws_iam_role.lambda_execution_role.arn
}

