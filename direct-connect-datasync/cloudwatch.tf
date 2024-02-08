resource "aws_cloudwatch_log_group" "datasync_log_group" {
  name = "/aws/datasync/Example"
  # Optionally, you can set retention in days
  retention_in_days = 14
}