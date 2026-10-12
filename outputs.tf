output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "ec2_instance_id" {
  description = "The unique ID of the deployed EC2 instance"
  value       = aws_instance.web.id
}

output "elastic_ip" {
  description = "The Elastic IP public address"
  value       = aws_eip.my_eip.public_ip
}

output "application_url" {
  description = "The public web application URL"
  value       = "http://${aws_eip.my_eip.public_ip}"
}

output "s3_bucket_name" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.app_bucket.id
}