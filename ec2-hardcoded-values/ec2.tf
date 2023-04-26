provider "aws"{
    region ="ap-south-1"
}

data "aws_ami" "myami" {
  most_recent      = true
  owners           = ["277477295271"]

  filter {
    name   = "name"
    values = ["Ec2-*"]
  }
}

resource "aws_instance" "myec2"{
    ami = data.aws_ami.myami.id
    key_name = var.key_name
    instance_type = var.instancetype
    subnet_id = "subnet-0273cf69d7ce9a746"
    security_groups = [aws_security_group.mysg.id]
}

resource "aws_security_group" "mysg" {
  name        = "sk-sg"
  description = "Allow port 22"
  vpc_id      = "vpc-00edf82a4c8e9074b"


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