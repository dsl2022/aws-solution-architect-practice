terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_ivs_channel" "example" {
  type = "BASIC"
}

data "aws_ivs_stream_key" "example" {
  channel_arn = aws_ivs_channel.example.arn
}

output "ingest_endpoint" {
  value = aws_ivs_channel.example.ingest_endpoint
}

output "stream_key" {
  value = data.aws_ivs_stream_key.example.value
}

output "playback_url" {
  value = aws_ivs_channel.example.playback_url
}
