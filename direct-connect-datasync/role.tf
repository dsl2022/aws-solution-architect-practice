resource "aws_iam_role" "datasync_s3_access_role" {
  name = "DataSyncS3AccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "datasync.amazonaws.com",
        },
        Action = "sts:AssumeRole",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "datasync_s3_access_policy_attachment" {
  role       = aws_iam_role.datasync_s3_access_role.name
  policy_arn = aws_iam_policy.datasync_s3_access.arn
}
