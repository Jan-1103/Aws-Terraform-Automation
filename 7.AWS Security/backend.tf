
terraform {
  backend "s3" {
    bucket       = "janani-tfstate"
    key          = "task-7-aws-security/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
