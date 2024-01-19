# Security Group for SSH access
resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  # SSH Ingress Rule
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust this to a more specific range for enhanced security
  }
   ingress {
    description = "PORT 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust this to a more specific range for enhanced security
  }
    ingress {
    description = "PORT 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust this to a more specific range for enhanced security
  }
  # Default Egress Rule (Allow all outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AllowSSH"
  }
}
