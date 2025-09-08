#VPC creation
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = { 
    Name = "CustomVPC"
    }
}

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
     Name = "public-sub1"
}
}

#IG creation
resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id 
}

#route Table creation
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
        Name = "customRT"
    }
   
  route {                     #edit route (adding public subnet )
   cidr_block ="0.0.0.0/0"
   gateway_id = aws_internet_gateway.name.id
}
}

#subnet association
 resource "aws_route_table_association" "name" {
   route_table_id = aws_route_table.name.id
   subnet_id = aws_subnet.name.id
 }

#security group creation
resource "aws_security_group" "allow_cust_sg" {
vpc_id = aws_vpc.name.id
name = "allow_cust_sg"

ingress {
description = "allow 80 port"
from_port = 80
to_port = 80
cidr_blocks = [ "0.0.0.0/0" ]
protocol = "TCP"
}

ingress {
    description = "allow 22/ssh"
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    
}
ingress {
    description = "allow 443/https"
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = [ "0.0.0.0/0" ]
    
}

}

#instance create
resource "aws_instance" "name" {
 ami = "ami-00ca32bbc84273381"
 instance_type = "t3.micro" 
  subnet_id = aws_subnet.name.id
 vpc_security_group_ids = [ aws_security_group.allow_cust_sg.id]
  associate_public_ip_address = true ###disable if dont want public ip 
 tags = {
    Name = "day-6"
 }
 
  } 
 



#nat gateway