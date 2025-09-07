resource "aws_instance" "name" {
  instance_type = "t3.micro"
  ami = "ami-00ca32bbc84273381" 
  
  tags = {
    Name = "day5"
  }
  
  }


resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  
}