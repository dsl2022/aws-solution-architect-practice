resource "aws_instance" "smb_server" {
  ami                    = var.ami_id # Update this to the latest Amazon Linux 2 AMI in your region
  instance_type          = "t2.micro"
  key_name               = var.key_name # Ensure you have this key pair created in AWS
  security_groups        = [aws_security_group.smb_sg.name]
  user_data              = <<-EOF
                          #!/bin/bash
                          sudo yum update -y
                          sudo yum install -y samba samba-client samba-common
                          mkdir /samba
                          chmod 777 /samba
                          (echo "samba_password"; echo "samba_password") | smbpasswd -a ec2-user
                          mv /etc/samba/smb.conf /etc/samba/smb.conf.backup
                          echo "[samba]" | sudo tee -a /etc/samba/smb.conf
                          echo "   comment = Samba" | sudo tee -a /etc/samba/smb.conf
                          echo "   path = /samba" | sudo tee -a /etc/samba/smb.conf
                          echo "   read only = no" | sudo tee -a /etc/samba/smb.conf
                          echo "   browsable = yes" | sudo tee -a /etc/samba/smb.conf
                          echo "   writable = yes" | sudo tee -a /etc/samba/smb.conf
                          echo "   guest ok = yes" | sudo tee -a /etc/samba/smb.conf
                          sudo systemctl start smb
                          sudo systemctl enable smb
                          EOF
  tags = {
    Name = "SMBServer"
  }
}
