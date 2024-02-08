resource "aws_s3_bucket" "example_bucket" {
  bucket = "example-bucket-for-datasync"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}