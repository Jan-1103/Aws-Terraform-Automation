
output "iam_role_name" {
  description = "Name of the EC2 IAM role"
  value       = aws_iam_role.ec2_role.name
}

output "instance_profile_name" {
  description = "Name of the EC2 instance profile"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "security_group_id" {
  description = "ID of the restricted security group"
  value       = aws_security_group.web_sg.id
}
