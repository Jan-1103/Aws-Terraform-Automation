output "ec2_public_ip" {
  value = aws_eip.web_eip.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.bucket.id
}
