output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.web.id
}

output "elastic_ip" {
  description = "Elastic IP address"
  value       = aws_eip.web_eip.public_ip
}

output "application_url" {
  description = "Application URL"
  value       = "http://${aws_eip.web_eip.public_ip}"
}

output "s3_bucket_name" {
  description = "S3 Bucket Name"
  value       = aws_s3_bucket.bucket.id
}
