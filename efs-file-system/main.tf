provider "aws" {
  region = "us-east-1" # Change this to your desired AWS region
}

resource "aws_efs_file_system" "example" {
  creation_token = "my-efs"
  encrypted= true
  tags = {
    Name = "myEfs"
  }

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS" # Options include AFTER_7_DAYS, AFTER_14_DAYS, AFTER_30_DAYS, etc.
  }
}


# Create mount targets for the EFS in each created subnet
resource "aws_efs_mount_target" "example" {
  depends_on = [aws_subnet.subnet1, aws_subnet.subnet2,aws_subnet.subnet3]
  for_each        = { for subnet in [aws_subnet.subnet1, aws_subnet.subnet2,aws_subnet.subnet3] : subnet.id => subnet }
  file_system_id  = aws_efs_file_system.example.id
  subnet_id       = each.value.id
  security_groups = [aws_security_group.efs_sg.id]
}


output "efs_id" {
  value = aws_efs_file_system.example.id
}

output "efs_dns_name" {
  value = aws_efs_file_system.example.dns_name
}