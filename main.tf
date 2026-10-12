# 1. VPC using variable
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags                 = { Name = "${var.environment}-vpc" }
}

# 2. Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.environment}-igw" }
}

# 3. Two Public Subnets using variables
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_1_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true
  tags                    = { Name = "${var.environment}-subnet-1" }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_2_cidr
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true
  tags                    = { Name = "${var.environment}-subnet-2" }
}

# 4. Route Table & Associations
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = { Name = "${var.environment}-route-table" }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

# 5. Security Group
resource "aws_security_group" "web_sg" {
  name        = "${var.environment}-web-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.main.id


  ingress {
    description = "SSH access from my IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["122.167.98.151/32"]
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

# 6. IAM Role & Instance Profile
resource "aws_iam_role" "ec2_role" {
  name = "project03-ec2-s3-role-2026" # <-- Updated here
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}


resource "aws_iam_instance_profile" "profile" {
  name = "project03-ec2-profile-2026"
  role = aws_iam_role.ec2_role.name
}

# Add this new section below the instance profile

resource "aws_iam_role_policy" "s3_access" {
  name = "project03-s3-access"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = aws_s3_bucket.bucket.arn
      },
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject"]
        Resource = "${aws_s3_bucket.bucket.arn}/*"
      }
    ]
  })
}

# 7. S3 Bucket


# 7. S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket        = "janani-project03-storage-2026-unique" # <-- Updated here
  force_destroy = false
}

# 8. EC2 Instance using variable ami_id and instance_type
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.profile.name

  # Install and start Nginx web server
  user_data = <<-EOF
    #!/bin/bash
    set -eux
    apt-get update -y
    apt-get install -y nginx
    systemctl enable --now nginx

    cat > /var/www/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
    <head>
      <title>Terraform Project 03</title>
    </head>
    <body>
      <h1>Terraform Project 03 Successful!</h1>
      <p>EC2 and Nginx are running.</p>
    </body>
    </html>
    HTML
  EOF

  tags = {
    Name = "${var.environment}-web-server"
  }
}

# 9. Elastic IP
resource "aws_eip" "web_eip" {
  instance = aws_instance.web.id
  domain   = "vpc"
}
