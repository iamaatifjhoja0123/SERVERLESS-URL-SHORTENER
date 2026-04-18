provider "aws" {
  region = "ap-south-1" 
}

# --- 1. Auto-generate SSH Key ---
resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "github-actions-amazon-key"
  public_key = tls_private_key.rsa_key.public_key_openssh
}

# --- 2. Security Group (Port 80 aur 22) ---
resource "aws_security_group" "frontend_sg" {
  name        = "frontend-docker-amazon-sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- 3. EC2 Instance setup (Amazon Linux) ---
resource "aws_instance" "frontend_server" {
  ami                    = "ami-0e12ffc2dd465f6e4" # Aapka diya hua exact AMI
  instance_type          = "t3.micro"              # Aapki choice
  key_name               = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]

  # Server start hote hi Amazon Linux ke hisab se Docker install hoga
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install docker -y
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ec2-user
              EOF

  tags = {
    Name = "Frontend-AmazonLinux-Server"
  }
}