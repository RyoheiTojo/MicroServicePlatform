#####################################
# VPC Settings
#####################################
resource "aws_vpc" "vpc_main" {
    cidr_block = var.root_segment
    tags = {
        Name = "scorehub vpc"
    }
}

#####################################
# Public Subnets1 Settings
#####################################
resource "aws_subnet" "vpc_main-public1-subnet" {
    vpc_id = aws_vpc.vpc_main.id
    cidr_block = var.public_segment1
    availability_zone = var.availability_zone1
    tags = {
        Name = "public-subnet1"
    }
}

#####################################
# Public Subnets2 Settings
#####################################
resource "aws_subnet" "vpc_main-public2-subnet" {
    vpc_id = aws_vpc.vpc_main.id
    cidr_block = var.public_segment2
    availability_zone = var.availability_zone2
    tags = {
        Name = "public-subnet2"
    }
}

#####################################
# Private Subnets Settings
#####################################
resource "aws_subnet" "vpc_main-private-subnet" {
    vpc_id = aws_vpc.vpc_main.id
    cidr_block = var.private_segment
    availability_zone = var.availability_zone1
    tags = {
        Name = "private-subnet"
    }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "main"
  }
}
