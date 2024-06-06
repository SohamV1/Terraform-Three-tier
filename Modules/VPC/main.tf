resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

#defining public subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.public_sub_availability_zone

  tags = {
    "Name" = var.public_subnet_name
  }
}

#defining public subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.public_subnet_cidr_block_2
  map_public_ip_on_launch = true
  availability_zone       = var.public_sub_availability_zone_2

  tags = {
    "Name" = var.public_subnet_name_2
  }
}

#defining private subnet 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.private_subnet_cidr_block
  map_public_ip_on_launch = false
  availability_zone       = var.private_sub_availability_zone

  tags = {
    "Name" = var.private_subnet_name
}
}

#defining private subnet 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.private_subnet_cidr_block_2
  map_public_ip_on_launch = false
  availability_zone       = var.private_sub_availability_zone_2

  tags = {
    "Name" = var.private_subnet_name_2
}
}

#defining internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    "Name" = "my-igw"
  }
}

#defining elastic ip for nat gateway
resource "aws_eip" "eip" {
    domain = "vpc"
}

#defining nat gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

#defining public rt
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

#defining private rt
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "b" {
   subnet_id = aws_subnet.private_subnet_1.id
   route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "d" {
   subnet_id = aws_subnet.private_subnet_2.id
   route_table_id = aws_route_table.private-rt.id
}
