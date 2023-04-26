

data "aws_ami" "myami" {
  most_recent      = true
 // owners           = ["self"]

 /* filter {
    name   = "name"
    values = ["Ec2-*"]
  } */
}

resource "aws_instance" "myec2"{
    ami = data.aws_ami.myami.id
    key_name = var.key_name
    instance_type = var.instancetype
    subnet_id = "subnet-06de958156b1c8056"
    security_groups = [aws_security_group.mysg.id]

    tags = {
    Name = "sk-instance"
  }
}

resource "aws_security_group" "mysg" {
  name        = var.sg_name
  description = "Allow port 22"
  vpc_id      = "vpc-0110f21bc838c9df0"


  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}