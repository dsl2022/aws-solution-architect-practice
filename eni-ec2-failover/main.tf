provider "aws" {
  region = "us-east-1"
}




resource "aws_network_interface" "eni" {
  subnet_id       = aws_subnet.private_subnet1.id
  private_ips     = ["10.0.5.5"]

  attachment {
    instance     = aws_instance.primary_instance.id
    device_index = 1
  }

  tags = {
    Name = "PrimaryENI"
  }
}
