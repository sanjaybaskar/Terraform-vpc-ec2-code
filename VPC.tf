provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "192.168.0.0/16"
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id 

}

  resource "aws_subnet" "mypubsub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1a"
  }

  resource "aws_subnet" "myprivsub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1b"
  }

  resource "aws_route_table" "mypubroutetb" {
    vpc_id = aws_vpc.myvpc.id
  }

    resource "aws_route_table" "myprivroutetb" {
    vpc_id = aws_vpc.myvpc.id
  }

  resource "aws_route" "pub_route" {
  route_table_id            = aws_route_table.mypubroutetb.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.myigw.id
}

  resource "aws_eip" "myeip" {
  instance = aws_instance.web.id
  vpc      = true
}

  resource "aws_nat_gateway" "mynatgw" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.mypubsub.id
  }

     resource "aws_route" "priv_route" {
  route_table_id            = aws_route_table.myprivroutetb.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.mynatgw.id
}
