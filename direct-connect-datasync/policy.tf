resource "aws_iam_policy" "datasync_s3_access" {
  name        = "DataSyncS3AccessPolicy"
  description = "Policy for AWS DataSync to access S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:ListBucketMultipartUploads",
        ],
        Effect   = "Allow",
        Resource = "arn:aws:s3:::your-bucket-name"
      },
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:AbortMultipartUpload",
          "s3:ListMultipartUploadParts",
        ],
        Effect   = "Allow",
        Resource = "arn:aws:s3:::your-bucket-name/*"
      },
    ]
  })
}
