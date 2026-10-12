
provider "aws" {
  region = var.aws_region
}

# IAM role that EC2 is allowed to assume
resource "aws_iam_role" "ec2_role" {
  name = "task7-secure-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Project = "Task-7-AWS-Security"
  }
}

# Instance profile connects the IAM role to EC2
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "task7-secure-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# Security group: HTTP for a web server; SSH only from your IP
resource "aws_security_group" "web_sg" {
  name        = "task7-secure-web-sg"
  description = "Restricted web server access"

  ingress {
    description = "HTTP web traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from your IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    description = "Outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "task7-secure-web-sg"
    Project = "Task-7-AWS-Security"
  }
}
