
provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "web_sg" {
  name        = "task5-web-server-sg"
  description = "Allow HTTP and restricted SSH access"

  ingress {
    description = "HTTP website traffic"
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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "task5-web-server-sg"
  }
}

resource "aws_instance" "web_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    dnf install -y nginx
    systemctl enable nginx
    systemctl start nginx

    cat > /usr/share/nginx/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
    <head>
      <title>My Terraform Web Server</title>
      <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 100px; background: #f0f8ff; }
        h1 { color: #145da0; }
        p { font-size: 20px; }
      </style>
    </head>
    <body>
      <h1>Welcome to My Terraform Web Server!</h1>
      <p>This website was deployed automatically using Terraform User Data.</p>
      <p>Web server: Nginx | Cloud: AWS EC2</p>
    </body>
    </html>
    HTML
  EOF

  tags = {
    Name = "task5-web-server"
  }
}

resource "aws_eip" "web_eip" {
  domain   = "vpc"
  instance = aws_instance.web_server.id

  tags = {
    Name = "task5-web-server-eip"
  }
}
