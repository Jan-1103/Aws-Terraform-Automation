variable "aws_region" {
  description = "AWS Region for deployment"
  type        = string
  default     = "eu-north-1"
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_1_cidr" {
  description = "CIDR block for the Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_2_cidr" {
  description = "CIDR block for the Subnet"
  type        = string
  default     = "10.0.2.0/24"
}
variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
  default     = "t3.micro" # t3.micro is great for eu-north-1
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance in eu-north-1 (Ubuntu 22.04 LTS)"
  type        = string
  default     = "ami-0989fb15ce71ba39e" # Valid Ubuntu 22.04 AMI for eu-north-1
}
