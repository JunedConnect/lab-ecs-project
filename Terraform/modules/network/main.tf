resource "aws_security_group" "LCT-SG" {
  name = "Threat-Composer-Tool-SG"
  description = "Allows Everything"
  vpc_id = aws_vpc.vpc.id

 ingress {
   from_port   = 0
   to_port     = 0
   protocol    = -1
   cidr_blocks = ["0.0.0.0/0"]
 }

 egress {
   from_port   = 0
   to_port     = 0
   protocol    = -1
   cidr_blocks = ["0.0.0.0/0"]
 }
}


resource "aws_lb_target_group" "TCT-TG" {
  name        = "Threat-Composer-Tool-TG"
  port        = "80"    #port 3000 or port 80 works here
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.vpc.id
}


resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}


resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2a"
}


resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2b"
}


resource "aws_subnet" "subnet3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2c"
}


resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.vpc.id
}


resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }
}


resource "aws_route_table_association" "RTA1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.RT.id
}


resource "aws_route_table_association" "RTA2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.RT.id
}


resource "aws_route_table_association" "RTA3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.RT.id
}