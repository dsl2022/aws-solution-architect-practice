resource "aws_instance" "primary_instance" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet1.id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.efs_sg.id]
  tags = {
    Name = "ec2-one"
  }
   associate_public_ip_address = true 
}

resource "aws_instance" "standby_instance" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet2.id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.efs_sg.id]
  tags = {
    Name = "ec2-two"
  }
   associate_public_ip_address = true 
}
