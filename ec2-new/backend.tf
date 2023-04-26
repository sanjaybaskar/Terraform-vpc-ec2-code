terraform {
  backend "s3" {
    bucket = "ec2-bucket-sk"
    key    = "ec2-new/terraform.tfstate"
    region = "us-east-1"
  }
}
