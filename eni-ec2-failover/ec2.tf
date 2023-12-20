resource "aws_instance" "primary_instance" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet1.id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
  tags = {
    Name = "PrimaryInstance"
  }
}

resource "aws_instance" "standby_instance" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet2.id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
  tags = {
    Name = "StandbyInstance"
  }
}

resource "aws_instance" "test_instance" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet1.id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
  tags = {
    Name = "TestInstance"
  }
}
