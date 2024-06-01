# Dynamic scaling with Terraform

# Implement dynamic scaling for a web application using AWS Auto Scaling Group and terraform to handle varying load patterns efficiently.

/*
aws_lauch_configuration
aws_autoscaling_group
*/

resource "aws_launch_configuration" "app" {
  name          = "app-launch-configuration"
  image_id      = "ami-012345"
  instance_type = "t2.micro"
  key_name      = "mykey"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app" {
  launch_configuration = aws_launch_configuration.app.id
  min_size             = 1
  max_size             = 5
  desired_capacity     = 2
  vpc_zone_identifier  = ["subnet-1", "subnet-2"]

  tag {
    key                 = "Name"
    value               = "AppAutoScaling"
    propagate_at_launch = true
  }
}   