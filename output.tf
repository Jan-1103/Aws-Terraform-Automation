output "vpc_id" {
  value = aws_vpc.main.id
}

output "ec2_instance_id" {
  value = aws_instance.web.id
}

output "elastic_ip" {
  value = aws_eip.web_eip.public_ip
}

output "application_url" {
  value = "http://${aws_eip.web_eip.public_ip}"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.bucket.id
}
