output "ec2_elastic_ip" {
  description = "The Elastic IP attached to the EC2 instance"
  value       = aws_eip.my_eip.public_ip
}

output "application_url" {
  description = "The public web application URL"
  value       = "http://${aws_eip.my_eip.public_ip}"
}

output "ec2_instance_id" {
  description = "The unique ID of the deployed EC2 instance"
  value       = aws_instance.web.id
}

output "s3_bucket_name" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.app_bucket.id
}