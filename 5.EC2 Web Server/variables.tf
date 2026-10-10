
variable "aws_region" {
  description = "AWS region for the web server"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2023 AMI ID"
  type        = string
}

variable "my_ip" {
  description = "Your public IP address in CIDR format for SSH access"
  type        = string
}
