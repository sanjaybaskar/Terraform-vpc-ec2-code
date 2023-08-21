provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "myvpc1" {
  cidr_block = var.vpc_cidr

      tags = {
    Name = "sk-vpc"
  }
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc1.id
}

resource "aws_subnet" "mypubsub" {
  vpc_id     = aws_vpc.myvpc1.id
  cidr_block = var.pub_cidr
  availability_zone = var.pub_az
}

resource "aws_subnet" "myprivsub" {
  vpc_id     = aws_vpc.myvpc1.id
  cidr_block = var.prvt_cidr
  availability_zone = var.prvt_az
}
resource "aws_route_table" "mypubroutetb" {
  vpc_id = aws_vpc.myvpc1.id
}

resource "aws_route_table" "myprivroutetb" {
  vpc_id = aws_vpc.myvpc1.id
}

resource "aws_route" "pub_route" {
  route_table_id            = aws_route_table.mypubroutetb.id
  destination_cidr_block    = var.dest_cidr
  gateway_id   = aws_internet_gateway.myigw.id
}

resource "aws_eip" "myeip" {
}

resource "aws_nat_gateway" "mynat" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.mypubsub.id
}

resource "aws_route" "priv_route" {
  route_table_id            = aws_route_table.myprivroutetb.id
  destination_cidr_block    = var.dest_cidr
  gateway_id   = aws_nat_gateway.mynat.id
}



