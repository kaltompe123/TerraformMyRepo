resource "aws_instance" "name" {
  instance_type = "t3.micro"
  ami = "ami-00ca32bbc84273381" 
  
  tags = {
    Name = "day5"
  }

  }