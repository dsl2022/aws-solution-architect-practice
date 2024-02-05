provider "aws" {
  region = "us-east-1"
}

resource "aws_kinesis_stream" "example_stream" {
  name             = "ExampleDataStream"
  shard_count      = 1
  retention_period = 24
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "example-bucket-for-iot-data"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}



resource "aws_kinesis_firehose_delivery_stream" "extended_s3_stream" {
  name        = "terraform-kinesis-firehose-extended-s3-test-stream"
  destination = "extended_s3"
  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.example_stream.arn
    role_arn           = aws_iam_role.firehose_delivery_role.arn
  }
  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_delivery_role.arn
    bucket_arn = aws_s3_bucket.example_bucket.arn
    cloudwatch_logging_options {
      enabled       = true
      log_group_name = aws_cloudwatch_log_group.firehose_log_group.name
      log_stream_name = "FirehoseDelivery"
    }
    processing_configuration {
      enabled = "true"

      processors {
        type = "Lambda"

        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "${aws_lambda_function.lambda_processor.arn}:$LATEST"
        }
      }
    }
  }
}