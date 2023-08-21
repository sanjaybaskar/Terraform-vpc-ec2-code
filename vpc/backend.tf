terraform {
  backend "s3" {
    bucket = "vpc-bucket-sk"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}
