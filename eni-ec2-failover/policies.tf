resource "aws_iam_role_policy" "lambda_logging" {
  name = "lambda_logging"
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "lambda_invoke_eni_policy" {
  name   = "lambda_policy"
  role   = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:AttachNetworkInterface",
          "ec2:DetachNetworkInterface",
          "ec2:DescribeNetworkInterfaces"
        ],
        Resource = "*"
      }
    ]
  })
}
