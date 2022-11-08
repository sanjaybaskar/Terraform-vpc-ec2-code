terraform {
  backend "s3" {
    bucket = "web-data-bt"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}
