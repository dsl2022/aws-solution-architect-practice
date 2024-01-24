# IAM role for the Lambda function
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

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
    ]
  })
}

# Policy to allow writing to the primary Aurora instance
resource "aws_iam_policy" "write_to_primary" {
  name   = "write_to_primary_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "rds-data:BatchExecuteStatement",
          "rds-data:BeginTransaction",
          "rds-data:CommitTransaction",
          "rds-data:ExecuteStatement",
          "rds-data:RollbackTransaction"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:rds:eu-west-2:123456789012:cluster:primary-cluster-identifier"
      },
    ]
  })
}

# Policy to allow reading from the secondary Aurora instance
resource "aws_iam_policy" "read_from_secondary" {
  name   = "read_from_secondary_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "rds-data:ExecuteStatement"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:rds:ap-southeast-2:123456789012:cluster:secondary-cluster-identifier"
      },
    ]
  })
}

# Attach the write policy to the role
resource "aws_iam_role_policy_attachment" "write_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.write_to_primary.arn
}

# Attach the read policy to the role
resource "aws_iam_role_policy_attachment" "read_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.read_from_secondary.arn
}

