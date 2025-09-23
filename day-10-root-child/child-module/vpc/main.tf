resource "aws_vpc" "name" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "custom_VPC"
    }
  
}

resource "aws_subnet" "subnet_1a" {
vpc_id = aws_vpc.name.id
cidr_block = var.subnet_cidr-1a
 availability_zone = var.az_for-subnet-1a
    }


 resource "aws_subnet" "subnet_1b" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.subnet_cidr-1b
    availability_zone = var.az_for-subnet-1b
    }