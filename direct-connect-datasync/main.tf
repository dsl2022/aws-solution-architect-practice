provider "aws" {
  region = "us-east-1" # Change this to your AWS region
}

# Assume the S3 bucket is already created and the Direct Connect is set up

# AWS DataSync Agent (to be installed on-premises)
resource "aws_datasync_agent" "example" {
  name = "ExampleDataSyncAgent"
  # IP address of the on-premises DataSync agent
  ip_address = "YOUR_ON_PREM_AGENT_IP"
}

# AWS DataSync Location for S3
resource "aws_datasync_location_s3" "example_s3_location" {
  s3_bucket_arn = aws_s3_bucket.example_bucket.arn
  s3_storage_class = "STANDARD"

  subdirectory    = "/destination-prefix" # Optional: Specify a subdirectory within the S3 bucket
  s3_config {
    bucket_access_role_arn = aws_iam_role.datasync_s3_access_role.arn
  }
}

# AWS DataSync Location for SMB
resource "aws_datasync_location_smb" "example_smb_location" {
  agent_arns = [aws_datasync_agent.example.arn]
  server_hostname = "YOUR_SMB_SERVER_HOSTNAME"
  subdirectory = "/your/source-path"

  user = "YourSMBUser"
  domain = "YourDomain" # Optional
  password = "YourPassword"

  # Ensure your VPC settings allow connection to the SMB server
}

# AWS DataSync Task
resource "aws_datasync_task" "example_task" {
  source_location_arn      = aws_datasync_location_smb.example_smb_location.arn
  destination_location_arn = aws_datasync_location_s3.example_s3_location.arn

  name = "ExampleDataSyncTask"
  cloudwatch_log_group_arn = aws_cloudwatch_log_group.datasync_log_group.arn
  
  # Additional options can be specified depending on your needs
}
