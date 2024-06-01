# IAM Configuration

/*
Manages IAM policies and roles usint terraform

*/

resource "aws_iam_role" "app_role" {
  name = "app_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Effect = "Allow",
      Sid    = ""
    }]
  })
}

resource "aws_iam_policy" "app_policy" {
  name        = "app_policy"
  description = "A policy that allows administrative actions"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "ec2:*",
      Effect = "Allow",


      Resource = "*"
    }]
  })
}