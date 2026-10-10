
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "my_ip" {
  description = "Your public IP address in CIDR format, for example 203.0.113.10/32"
  type        = string
}
