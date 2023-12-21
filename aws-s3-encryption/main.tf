terraform {
  required_version = "~> 1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.22.0"
    }
  }
}


resource "aws_s3_bucket" "web_bucket" {
  bucket = "my-sse-c-bucket"
  tags = {
    Name = "SSE C Bucket"
  }
}

resource "aws_s3_bucket" "client_side_encryption_bucket" {
  bucket = "my-client-side-encryption-bucket"
  tags = {
    Name = "Client Side Encryption Bucket"
  }
}