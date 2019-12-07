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
# Public Subnets Settings
#####################################
resource "aws_subnet" "vpc_main-public-subnet" {
    vpc_id = aws_vpc.vpc_main.id
    cidr_block = var.public_segment
    tags = {
        Name = "public-subnet"
    }
}

#####################################
# Private Subnets Settings
#####################################
resource "aws_subnet" "vpc_main-private-subnet" {
    vpc_id = aws_vpc.vpc_main.id
    cidr_block = var.private_segment
    tags = {
        Name = "private-subnet"
    }
}
