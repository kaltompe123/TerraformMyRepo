#vpc creation 
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
tags = {    
    Name = "customVPC"
}  
}

#internet gateway & attachment 
resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id
   }  
  
#subnet creation
resource "aws_subnet" "pub_subnet-1a" {
vpc_id=aws_vpc.name.id    
cidr_block = "10.0.1.0/24"
availability_zone = "us-east-1a"
tags = {
    Name = "pub_subnet-1a"
}
}

#route table 
resource "aws_route_table" "pubRT" {
vpc_id =aws_vpc.name.id
route {    #add /edit route
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.name.id
}
tags = {
    Name = "pubRT"
}

}

#subnet association
resource "aws_route_table_association" "name" {
route_table_id = aws_route_table.pubRT.id
subnet_id = aws_subnet.pub_subnet-1a.id  
}

#security group
resource "aws_security_group" "allow_SG" {
  vpc_id = aws_vpc.name.id
  ingress  {
   description = "allow ssh"
   from_port = 22
   to_port   = 22
   protocol = "TCP"
   cidr_blocks = ["0.0.0.0/0"]
     }

     ingress  {
   description = "allow http"
   from_port = 80
   to_port   = 80
   protocol = "TCP"
   cidr_blocks = ["0.0.0.0/0"]
     }
      ingress  {
   description = "allow https"
   from_port = 443
   to_port   = 443
   protocol = "TCP"
   cidr_blocks = ["0.0.0.0/0"]
     }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" #all protocols 
    cidr_blocks      = ["0.0.0.0/0"]
    
     }
     
     tags = {
        Name = "SG"
     }
}

#instance create 
resource "aws_instance" "name" {
 ami = "ami-00ca32bbc84273381"
 instance_type = "t3.micro" 
 subnet_id = aws_subnet.pub_subnet-1a.id
 #security_groups = [ "allow_cust_sg" ]
 vpc_security_group_ids = [aws_security_group.allow_SG.id]
 associate_public_ip_address = true
 tags = {
    Name = "pub-instance"
 }
}


#craete elastic ip
resource "aws_eip" "name" {

}

#create natgateway in public 
resource "aws_nat_gateway" "name" {
  subnet_id = aws_subnet.pub_subnet-1a.id
 allocation_id = aws_eip.name.id
 
    }

#private subnet 
resource "aws_subnet" "pvt-subnet-1b" {
    vpc_id = aws_vpc.name.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.2.0/24"
}

#route private route table
resource "aws_route_table" "pvt_RT" {
vpc_id = aws_vpc.name.id
route {
 cidr_block = "0.0.0.0/0"
 nat_gateway_id = aws_nat_gateway.name.id
 
} 
tags =  {
    Name = "pvt_RT"
 } 
}

resource "aws_route_table_association" "PVT_RT_assocication" {
 route_table_id = aws_route_table.pvt_RT.id
 subnet_id = aws_subnet.pvt-subnet-1b.id

}

#private instance 
resource "aws_instance" "pvt-instance" {
 ami = "ami-00ca32bbc84273381"
 instance_type = "t3.micro"  
 subnet_id = aws_subnet.pvt-subnet-1b.id
 vpc_security_group_ids = [ aws_security_group.allow_SG.id ]
 key_name = "key"
 tags = {
   Name = "pvt-instance"
 }

}