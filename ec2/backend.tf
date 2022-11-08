terraform {
  backend "s3" {
    bucket = "web-data-bt"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"
  }
}
