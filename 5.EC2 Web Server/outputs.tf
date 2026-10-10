
output "ec2_instance_id" {
  description = "ID of the EC2 web server"
  value       = aws_instance.web_server.id
}

output "elastic_ip" {
  description = "Public Elastic IP address"
  value       = aws_eip.web_eip.public_ip
}

output "application_url" {
  description = "URL of the web server"
  value       = "http://${aws_eip.web_eip.public_ip}"
}
