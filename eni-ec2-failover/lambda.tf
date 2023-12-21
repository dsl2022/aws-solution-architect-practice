resource "aws_lambda_function" "detach_reattach_eni_lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "detach_reattach_eni_lambda"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "python3.8"
   environment {
    variables = {
      PRIMARY_INSTANCE_ID = aws_instance.primary_instance.id
      STANDBY_INSTANCE_ID = aws_instance.standby_instance.id
      ENI_ID = aws_network_interface.eni.id
    }
  }
}


data "archive_file" "lambda_zip" {
    type        = "zip"
    source_file = "${path.module}/lambda_function.py"
    output_path = "${path.module}/lambda_function.zip"
}


resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
      },
    ],
  })
}

